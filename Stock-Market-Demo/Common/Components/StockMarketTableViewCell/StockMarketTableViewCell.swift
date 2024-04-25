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
    @IBOutlet var firstDetailLabel: UILabel!
    @IBOutlet var secondDetailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with model: StockMarketCellUIModel?) {
        
    }
    
    func configure(with model: StockInfo?) {
        stockCodLabel.text = model?.cod
    }
}
