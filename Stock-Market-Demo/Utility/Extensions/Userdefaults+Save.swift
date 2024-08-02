//
//  Userdefaults+Save.swift
//  Stock-Market-Demo
//
//  Created by Artun Erol on 26.04.2024.
//

import Foundation

extension UserDefaults {
    func save(newValue: String, stockCode: String) {
        UserDefaults.standard.setValue(newValue, forKey: stockCode)
    }
    
    func get(stockCode: String) -> String? {
        UserDefaults.standard.string(forKey: stockCode)
    }
}
