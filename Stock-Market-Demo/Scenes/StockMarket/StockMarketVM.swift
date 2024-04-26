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
    private var timer = Timer()
    
    private let stockInfoArray: BehaviorRelay<[StockInfoModel]> = .init(value: [])
    let stockListResponse: BehaviorRelay<StockListResponse?> = .init(value: nil)
    let stockListUIModel: BehaviorRelay<[StockMarketUIModel]> = .init(value: [])
    
    var firstColumn: QueryEnum = .las
    var secondColumn: QueryEnum = .pdd
    
    init() {
        bind()
        fetchStockList()
        
        group.notify(queue: .main) {
            self.fetchStockListDetail()
            self.initTimer()
        }
    }
    
    deinit {
        timer.invalidate()
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
                    group.leave()
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
                    self?.updateStockUIModel(with: response)
                case .failure(let error):
                    print(error)
                }
            }
    }
}

// MARK: - Helpers
extension StockMarketVM {
    private func updateStockUIModel(with detailResponse: StockDetailResponse) {
        let stockInfoArray = self.stockInfoArray.value
        var stockUIModel: [StockMarketUIModel] = []
        
        stockInfoArray.forEach { stockInfo in
            if let detailData = detailResponse.stockDetailArray.first(where: {$0.tke == stockInfo.key}) {
                stockUIModel.append(StockMarketUIModel(stockCode: stockInfo.stockCode,
                                                       stockDetail: detailData))
            }
        }
        
        self.stockListUIModel.accept(stockUIModel)
    }
    
    private func initTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.fetchStockListDetail()
        })
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
