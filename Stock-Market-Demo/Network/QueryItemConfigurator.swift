//
//  QueryItemConfigurator.swift
//  Stock-Market-Demo
//
//  Created by Artun Erol on 25.04.2024.
//

import Foundation

enum QueryEnum: String {
    case tke = "tke"
    case clo = "clo"
    case pdd = "pdd"
    case las = "las"
    case ddi = "ddi"
}

class QueryItemConfigurator {
    var queryItems: [URLQueryItem] = []
    
    init(stockInfo: [StockInfo]?) {
        var stockQueryValue: String = ""
        stockInfo?.forEach({ stock in
            stockQueryValue += stock.tke + "~"
        })
        queryItems = [URLQueryItem(name: "fields", value: QueryEnum.ddi.rawValue),
                URLQueryItem(name: "stcs", value: stockQueryValue)]
    }
    
    func changeQueryParam() {
        
    }
}
