//
//  StockMarketVC.swift
//  Stock-Market-Demo
//
//  Created by Artun Erol on 25.04.2024.
//

import UIKit

class StockMarketVC: UIViewController {
    private let viewModel = StockMarketVM()

    @IBOutlet var stockTableView: UITableView! {
        didSet {
            stockTableView.delegate = self
            stockTableView.dataSource = self
            stockTableView.register(UINib(nibName: StockMarketTableViewCell.getNibName(),
                                          bundle: nil),
                                    forCellReuseIdentifier: StockMarketTableViewCell.identifier)
            
            stockTableView.register(UINib(nibName: StockHeaderView.identifier,
                                          bundle: nil),
                                    forCellReuseIdentifier: StockHeaderView.identifier)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchStockList()
    }
}

// MARK: - TableViewDelegate & DataSource funcs

extension StockMarketVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view: StockHeaderView = .fromNib()
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StockMarketTableViewCell.identifier,
                                                       for: indexPath) as? StockMarketTableViewCell else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}
