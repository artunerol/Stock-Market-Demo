//
//  StockDetailResponse.swift
//  Stock-Market-Demo
//
//  Created by Artun Erol on 25.04.2024.
//

import Foundation

struct StockDetailResponse: Codable {
    let l: [L]
}

// MARK: - L
struct L: Codable {
    let tke, clo, pdd, hig, las: String
}
