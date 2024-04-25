//
//  NetworkSession.swift
//  Stock-Market-Demo
//
//  Created by Artun Erol on 25.04.2024.
//

import Foundation

class NetworkSession {
    func request<T: Codable>(model: T.Type,
                             endpoint: EndpointEnum,
                             completion: @escaping (Result<T, CustomError>) -> Void) {
        let urlString = NetworkConfiguration.baseAPI + endpoint.getURLString()
        let url = urlString.asURL()
        var request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) {data, _, error in
            guard let data = data else { return }
            
            if let error = error {
                completion(.failure(.requestError(error: error)))
            }
            
            if let dataResponse = try? JSONDecoder().decode(model, from: data) {
                completion(.success(dataResponse))
            } else {
                completion(.failure(.throwError))
            }
        }.resume()
    }
}
