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
    
    func configure(with model: StockMarketUIModel?, firstColumn: QueryEnum, secondColumn: QueryEnum) {
        stockCodLabel.text = model?.stockDetail.tke
        updateTimeLabel.text = model?.stockDetail.clo
        
        switch firstColumn {
        case .pdd:
            firstFilterLabel.text = model?.stockDetail.pdd
        case .ddi:
            firstFilterLabel.text = model?.stockDetail.ddi
        case .hig:
            firstFilterLabel.text = model?.stockDetail.hig
        case .las:
            firstFilterLabel.text = model?.stockDetail.las
        }
        
        switch secondColumn {
        case .pdd:
            secondFilterLabel.text = model?.stockDetail.pdd
        case .ddi:
            secondFilterLabel.text = model?.stockDetail.ddi
        case .hig:
            secondFilterLabel.text = model?.stockDetail.hig
        case .las:
            secondFilterLabel.text = model?.stockDetail.las
        }
    }
}
