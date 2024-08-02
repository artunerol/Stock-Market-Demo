//
//  EndpointEnum.swift
//  Stock-Market-Demo
//
//  Created by Artun Erol on 25.04.2024.
//

import Foundation

enum EndpointEnum {
    case stockList
    case stockDetail
    
    func getURLString() -> String {
        switch self {
        case .stockList:
            return "/ForeksMobileInterviewSettings"
        case .stockDetail:
            return "/ForeksMobileInterview"
        }
    }
}
