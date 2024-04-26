//
//  StockDetailResponse.swift
//  Stock-Market-Demo
//
//  Created by Artun Erol on 25.04.2024.
//

import Foundation

struct StockDetailResponse: Codable {
    let stockDetailArray: [StockDetail]
    
    enum CodingKeys: String, CodingKey {
        case stockDetailArray = "l"
    }
}

// MARK: - L
struct StockDetail: Codable {
    let tke, clo, las: String
    let ddi, pdd, hig: String?
}
