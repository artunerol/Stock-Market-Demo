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
    let key, updateTime, lastValue: String
    let diff, diffPercengate: String?
    
    enum CodingKeys:String, CodingKey {
        case key = "tke"
        case updateTime = "clo"
        case diffPercengate = "pdd"
        case lastValue = "las"
        case diff = "ddi"
    }
}
