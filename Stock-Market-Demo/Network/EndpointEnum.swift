//
//  EndpointEnum.swift
//  Stock-Market-Demo
//
//  Created by Artun Erol on 25.04.2024.
//

import Foundation

enum EndpointEnum {
    case stockList
    
    func getURLString() -> String {
        switch self {
        case .stockList:
            return "/ForeksMobileInterviewSettings"
        }
    }
}
