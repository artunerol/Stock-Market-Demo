//
//  QueryItemConfigurator.swift
//  Stock-Market-Demo
//
//  Created by Artun Erol on 25.04.2024.
//

import Foundation

class QueryItemConfigurator {
    var queryItems: [URLQueryItem] = []
    
    init(stockInfo: [StockInfo]?) {
        var stockQueryValue: String = ""
        stockInfo?.forEach({ stock in
            stockQueryValue += stock.tke + "~"
        })
        queryItems = [URLQueryItem(name: "fields", value: "pdd,sel"),
                URLQueryItem(name: "stcs", value: stockQueryValue)]
    }
}
