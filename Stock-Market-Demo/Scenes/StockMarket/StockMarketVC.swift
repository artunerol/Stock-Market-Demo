//
//  StockMarketVC.swift
//  Stock-Market-Demo
//
//  Created by Artun Erol on 25.04.2024.
//

import UIKit
import RxSwift
import RxCocoa

class StockMarketVC: UIViewController {
    private let disposeBag = DisposeBag()
    private let viewModel = StockMarketVM()

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
        bind()
    }
}

// MARK: - Rx Bindings
extension StockMarketVC {
    func bind() {
        viewModel
            .stockListResponse
            .skip(1)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] response in
                self?.stockTableView.reloadData()
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - TableViewDelegate & DataSource funcs

extension StockMarketVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("StockHeaderView", owner: self, options: nil)?.first as? StockHeaderView
        headerView?.delegate = self
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        45
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.stockListResponse.value?.stockInfo.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StockMarketTableViewCell.identifier,
                                                       for: indexPath) as? StockMarketTableViewCell else { return UITableViewCell() }
        cell.configure(with: viewModel.stockListResponse.value?.stockInfo[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}

extension StockMarketVC: StockHeaderDelegate {
    func firstButtonPressed() {
        print("from vc")
    }
    
    func secondButtonPressed() {
        print("from vc")
    }
}
