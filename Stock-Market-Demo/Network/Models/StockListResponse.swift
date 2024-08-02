//
//  StockList.swift
//  Stock-Market-Demo
//
//  Created by Artun Erol on 25.04.2024.
//

import Foundation

struct StockListResponse: Codable {
    let stockInfo: [StockInfo]
    let stockDetailInfo: [StockDetailInfo]
    
    enum CodingKeys: String, CodingKey {
        case stockInfo = "mypageDefaults"
        case stockDetailInfo = "mypage"
    }
}

// MARK: - Mypage
struct StockDetailInfo: Codable {
    let name, key: String
}

// MARK: - MypageDefault
struct StockInfo: Codable {
    let cod, tke: String
}

