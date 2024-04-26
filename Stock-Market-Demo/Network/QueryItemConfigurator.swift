//
//  QueryItemConfigurator.swift
//  Stock-Market-Demo
//
//  Created by Artun Erol on 25.04.2024.
//

import Foundation

enum QueryEnum: String {
    case pdd = "pdd"
    case ddi = "ddi"
    case hig = "hig"
    case las = "las"
}

class QueryItemConfigurator {
    var queryItems: [URLQueryItem] = []
    private var stockCodes: String = ""
    
    init(stockInfo: [StockInfo]?) {
        stockInfo?.forEach({ stock in
            stockCodes += stock.tke + "~"
        })
        addQueryParam(with: [.pdd, .ddi, .hig, .las])
    }
    
    func addQueryParam(with query: [QueryEnum]) {
        var fieldQuery = ""
        query.forEach {fieldQuery += $0.rawValue + ","}
        
        queryItems = [URLQueryItem(name: "fields", value: fieldQuery),
                      URLQueryItem(name: "stcs", value: stockCodes)]
    }
}
