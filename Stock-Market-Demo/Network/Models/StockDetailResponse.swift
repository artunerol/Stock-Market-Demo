//
//  StockDetailResponse.swift
//  Stock-Market-Demo
//
//  Created by Artun Erol on 25.04.2024.
//

import Foundation

struct StockDetailResponse: Codable {
    let l: [StockDetail]
}

// MARK: - L
struct StockDetail: Codable {
    let tke, clo, pdd, las: String
}
