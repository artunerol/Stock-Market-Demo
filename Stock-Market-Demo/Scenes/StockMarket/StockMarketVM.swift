//
//  StockMarketVM.swift
//  Stock-Market-Demo
//
//  Created by Artun Erol on 25.04.2024.
//

import Foundation
import RxRelay

class StockMarketVM {
    let networkSession = NetworkSession()
    let stockListResponse: BehaviorRelay<StockListResponse?> = .init(value: nil)
    
    func fetchStockList() {
        networkSession
            .request(model: StockListResponse.self,
                     endpoint: .stockList) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let response):
                    self.stockListResponse.accept(response)
                case .failure(let error):
                    print(error) //TODO: Error handling
                }
            }
    }
}
