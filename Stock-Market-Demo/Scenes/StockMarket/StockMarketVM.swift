//
//  StockMarketVM.swift
//  Stock-Market-Demo
//
//  Created by Artun Erol on 25.04.2024.
//

import Foundation
import RxSwift
import RxCocoa

class StockMarketVM {
    private let group = DispatchGroup()
    private let disposeBag = DisposeBag()
    private let networkSession = NetworkSession()
    lazy var queryItemConfigurator: QueryItemConfigurator = {
        let configurator = QueryItemConfigurator(stockInfo: stockListResponse.value?.stockInfo)
        return configurator
    }()
    
    private let stockInfoArray: BehaviorRelay<[StockInfoModel]> = .init(value: [])
    let stockListResponse: BehaviorRelay<StockListResponse?> = .init(value: nil)
    let stockListUIModel: BehaviorRelay<[StockMarketUIModel]> = .init(value: [])
    
    init() {
        bind()
        fetchStockList()
        
        group.notify(queue: .main) {
            self.fetchStockListDetail()
        }
    }
    
    func fetchStockList() {
        group.enter()
        networkSession
            .request(model: StockListResponse.self,
                     endpoint: .stockList) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let response):
                    self.stockListResponse.accept(response)
                    group.leave()
                case .failure(let error):
                    print(error) //TODO: Error handling
                }
            }
    }
    
    func fetchStockListDetail() {
        networkSession
            .request(model: StockDetailResponse.self,
                     endpoint: .stockDetail,
                     queryParams: queryItemConfigurator.queryItems) { [weak self] result in
                switch result {
                case .success(let response):
                    self?.createStockUIModel(with: response)
                case .failure(let error):
                    print(error)
                }
            }
    }
}

// MARK: - Helpers
extension StockMarketVM {
    private func createStockUIModel(with detailResponse: StockDetailResponse) {
        let stockInfoArray = self.stockInfoArray.value
        var stockUIModel: [StockMarketUIModel] = []
        
        stockInfoArray.forEach { stockInfo in
            let detailData = detailResponse.stockDetailArray.first(where: {$0.key == stockInfo.key})
            stockUIModel.append(StockMarketUIModel(stockCode: stockInfo.stockCode,
                                                   updateTime: detailData?.updateTime ?? "",
                                                   firstValue: detailData?.lastValue ?? "",
                                                   secondValue: detailData?.diff ?? "",
                                                   key: stockInfo.stockCode))
        }
        
        self.stockListUIModel.accept(stockUIModel)
    }
}

// MARK: - Bindings
extension StockMarketVM {
    func bind() {
        bindStockListResponse()
    }
    
    private func bindStockListResponse() {
        stockListResponse
            .observe(on: MainScheduler.instance)
            .skip(1)
            .subscribe(onNext: { [weak self] listInfo in
                guard let self = self else { return }
                var stockInfoArray: [StockInfoModel] = []
                listInfo?.stockInfo.forEach({ stockInfo in
                    stockInfoArray.append(StockInfoModel(stockCode: stockInfo.cod,
                                                                  key: stockInfo.tke))
                })
                self.stockInfoArray.accept(stockInfoArray)
            })
            .disposed(by: disposeBag)
    }
}
