//
//  StockList.swift
//  Stock-Market-Demo
//
//  Created by Artun Erol on 25.04.2024.
//

import Foundation

struct StockListResponse: Codable {
    let mypageDefaults: [MypageDefault]
    let mypage: [Mypage]
}

// MARK: - Mypage
struct Mypage: Codable {
    let name, key: String
}

// MARK: - MypageDefault
struct MypageDefault: Codable {
    let cod, gro, tke, def: String
}

