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
                             queryParams: [URLQueryItem]? = nil,
                             completion: @escaping (Result<T, CustomError>) -> Void) {
        let urlString = NetworkConfiguration.baseAPI + endpoint.getURLString()
        var urlComponent = URLComponents(string: urlString)
        
        if let queryParams = queryParams {
            urlComponent?.queryItems = queryParams
        }
        
        guard let url = urlComponent?.url else { return }
        let request = URLRequest(url: url)
        
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
