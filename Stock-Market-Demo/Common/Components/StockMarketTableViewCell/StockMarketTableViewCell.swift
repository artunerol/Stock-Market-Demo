//
//  StockMarketTableViewCell.swift
//  Stock-Market-Demo
//
//  Created by Artun Erol on 25.04.2024.
//

import UIKit

class StockMarketTableViewCell: UITableViewCell {
    static let identifier = "StockMarketTableViewCell"
    
    @IBOutlet var arrowImageView: UIImageView! {
        didSet {
            
        }
    }
    
    @IBOutlet var stockCodLabel: UILabel! {
        didSet {
            stockCodLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        }
    }
    
    @IBOutlet var updateTimeLabel: UILabel! {
        didSet {
            updateTimeLabel.font = .systemFont(ofSize: 10, weight: .regular)
        }
    }
    
    @IBOutlet var firstFilterLabel: UILabel! {
        didSet {
            firstFilterLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        }
    }
    
    @IBOutlet var secondFilterLabel: UILabel! {
        didSet {
            secondFilterLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        }
    }
    
    func configure(with model: StockMarketUIModel?) {
        stockCodLabel.text = model?.stockCode
        updateTimeLabel.text = model?.updateTime
        firstFilterLabel.text = model?.firstValue
        secondFilterLabel.text = model?.secondValue
    }
    
    func configure(with model: StockInfo?) {
        stockCodLabel.text = model?.cod
    }
}
