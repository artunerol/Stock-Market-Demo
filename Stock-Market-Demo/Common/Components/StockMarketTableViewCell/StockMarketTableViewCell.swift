//
//  StockMarketTableViewCell.swift
//  Stock-Market-Demo
//
//  Created by Artun Erol on 25.04.2024.
//

import UIKit

class StockMarketTableViewCell: UITableViewCell {
    static let identifier = "StockMarketTableViewCell"
    private var lastUpdateValue: String = ""
    private var lastUpdateTime: String = ""
    
    @IBOutlet var arrowImageView: UIImageView! {
        didSet {
            arrowImageView.tintColor = .clear
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
        calculateDifference(stockCode: model?.stockCode ?? "",
                            newTime: model?.stockDetail.clo ?? "", 
                            newValue: model?.stockDetail.las ?? "")
        
        stockCodLabel.text = model?.stockDetail.tke
        updateTimeLabel.text = model?.stockDetail.clo
        
        lastUpdateTime = model?.stockDetail.clo ?? ""
        
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
    
    private func calculateDifference(stockCode: String, newTime: String, newValue: String) {
        let oldValue = UserDefaults.standard.get(stockCode: stockCode)
        
        if newValue > (oldValue ?? "") {
            arrowImageView.image = UIImage(systemName: "arrow.up")
            arrowImageView.tintColor = .green
        } else {
            arrowImageView.image = UIImage(systemName: "arrow.down")
            arrowImageView.tintColor = .red
        }
        
        UserDefaults.standard.save(newValue: newValue, stockCode: stockCode)
        
        if newTime != lastUpdateTime && lastUpdateTime != "" {
            changeColorAnimation()
        }
    }
    
    private func changeColorAnimation() {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: .curveEaseIn) {
            self.contentView.backgroundColor = .init(white: 1, alpha: 0.2)
        } completion: { isCompleted in
            if isCompleted {
                UIView.animate(withDuration: 0.2) {
                    self.contentView.backgroundColor = .clear
                }
            }
        }
    }
}
