//
//  UIView+Nib.swift
//  Stock-Market-Demo
//
//  Created by Artun Erol on 25.04.2024.
//

import UIKit

extension UIView {
    static func loadViewFromNib<T: UIView>() -> T {
        let nib = UINib(nibName: String(describing: T.self), bundle: nil)
        guard let view = nib.instantiate(withOwner: T.self, options: nil)[0] as? UIView else {
            assertionFailure("view not created, please check file names")
            return UIView(frame: .zero) as! T
        }
        return view as! T
    }
}
