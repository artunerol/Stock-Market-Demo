//
//  NetworkConfiguration.swift
//  Stock-Market-Demo
//
//  Created by Artun Erol on 25.04.2024.
//

import Foundation

enum CustomError: Error {
    case requestError(error: Error)
    case throwError
    case defaultError
}

class NetworkConfiguration {
    static let baseAPI = "https://sui7963dq6.execute-api.eu-central-1.amazonaws.com/default"
}
