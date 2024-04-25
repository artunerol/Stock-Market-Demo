//
//  StockMarketVC.swift
//  Stock-Market-Demo
//
//  Created by Artun Erol on 25.04.2024.
//

import UIKit

class StockMarketVC: UIViewController {

    @IBOutlet var stockTableView: UITableView! {
        didSet {
            stockTableView.delegate = self
            stockTableView.dataSource = self
            stockTableView.register(UINib(nibName: StockMarketTableViewCell.getNibName(),
                                          bundle: nil),
                                    forCellReuseIdentifier: StockMarketTableViewCell.identifier)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension StockMarketVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StockMarketTableViewCell.identifier,
                                                       for: indexPath) as? StockMarketTableViewCell else { return UITableViewCell() }
        return cell
    }
}
