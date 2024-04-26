//
//  StockHeaderView.swift
//  Stock-Market-Demo
//
//  Created by Artun Erol on 25.04.2024.
//

import UIKit

protocol StockHeaderDelegate: AnyObject {
    func firstButtonPressed()
    func secondButtonPressed()
}

class StockHeaderView: UIView {
    static let identifier = "StockHeaderView"
    
    weak var delegate: StockHeaderDelegate?

    @IBOutlet var symbolLabel: UILabel!
    @IBOutlet var firstButtonOutlet: UIButton!
    @IBOutlet var secondButtonOutlet: UIButton!
    
    @IBAction func firstButtonPressed(_ sender: Any) {
        delegate?.firstButtonPressed()
    }
    @IBAction func secondButtonPressed(_ sender: Any) {
        delegate?.secondButtonPressed()
    }
}
