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
    var queryItems: [URLQueryItem] {
        get {
            var stockQueryValue: String = ""
            stockListResponse.value?.mypageDefaults.forEach({ stock in
                stockQueryValue += stock.tke + "~"
            })
            return [URLQueryItem(name: "fields", value: "pdd,sel"),
                    URLQueryItem(name: "stcs", value: stockQueryValue)]
        }
    }
    
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
                     queryParams: queryItems) { result in
                switch result {
                case .success(let response):
                    print(response)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
