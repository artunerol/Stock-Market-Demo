//
//  TableviewCell+Nibname.swift
//  Stock-Market-Demo
//
//  Created by Artun Erol on 25.04.2024.
//

import Foundation
import UIKit

extension UITableViewCell {
    static func getNibName() -> String {
        String(describing: Self.self)
    }
}
