//
//  String+URL.swift
//  Stock-Market-Demo
//
//  Created by Artun Erol on 25.04.2024.
//

import Foundation

extension String {
    func asURL() -> URL {
        guard let url = URL(string: self) else { return URL(fileURLWithPath: "") }
        return url
    }
}
