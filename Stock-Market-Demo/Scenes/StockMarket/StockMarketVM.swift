//
//  StockMarketVM.swift
//  Stock-Market-Demo
//
//  Created by Artun Erol on 25.04.2024.
//

import Foundation
import RxRelay

class StockMarketVM {
    private let group = DispatchGroup()
    let networkSession = NetworkSession()
    let stockListResponse: BehaviorRelay<StockListResponse?> = .init(value: nil)
    lazy var queryItemConfigurator: QueryItemConfigurator = {
        let configurator = QueryItemConfigurator(stockInfo: stockListResponse.value?.stockInfo)
        return configurator
    }()
    
    init() {
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
                     queryParams: queryItemConfigurator.queryItems) { result in
                switch result {
                case .success(let response):
                    print(response)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
