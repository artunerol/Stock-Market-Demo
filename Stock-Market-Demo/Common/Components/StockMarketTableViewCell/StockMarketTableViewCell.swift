//
//  StockMarketTableViewCell.swift
//  Stock-Market-Demo
//
//  Created by Artun Erol on 25.04.2024.
//

import UIKit

class StockMarketTableViewCell: UITableViewCell {
    static let identifier = "StockMarketTableViewCell"

    @IBOutlet var arrowImageView: UIImageView!
    @IBOutlet var stockCodLabel: UILabel!
    @IBOutlet var updateTimeLabel: UILabel!
    @IBOutlet var firstDetailLabel: UILabel!
    @IBOutlet var secondDetailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
