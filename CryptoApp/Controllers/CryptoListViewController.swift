//
//  ViewController.swift
//  CryptoApp
//
//  Created by Yunus Emre Koca on 4.09.2022.
//

import UIKit
import RxSwift
import RxCocoa

final class CryptoListViewController: UIViewController {
    
    private let cryptoListViewModel: CryptoListViewModel
    private let activityView: UIActivityIndicatorView
    private let bag: DisposeBag
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(CryptoTableViewCell.self, forCellReuseIdentifier: CryptoTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    init() {
        self.activityView = UIActivityIndicatorView(style: .large)
        self.bag = DisposeBag()
        self.cryptoListViewModel = CryptoListViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cryptocurrencies"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        
        applyConstraints()
        initViewModel()
    }
    
    private func applyConstraints() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
    }
    
    private func initViewModel() {
        cryptoListViewModel.cryptocurrencies.bind(to: tableView.rx.items(cellIdentifier: CryptoTableViewCell.identifier, cellType: CryptoTableViewCell.self)) { row, cryptocurrency, cell in
            let cryptocurrencyVM = CryptocurrencyViewModel(model: cryptocurrency)
            cell.configureCryptoCell(with: cryptocurrencyVM)
        }.disposed(by: bag)
        
        cryptoListViewModel.error.subscribe(onNext: { [weak self] error in
            self?.showAlert(title: "Error", message: error.localizedDescription)
        }).disposed(by: bag)
        
        cryptoListViewModel.isLoading.subscribe(onNext: { [weak self] bool in
            bool ? self?.startActivityIndicator() : self?.stopActivityIndicator()
        }).disposed(by: bag)
        
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            self?.tableView.deselectRow(at: indexPath, animated: true)
        }).disposed(by: bag)
        
        cryptoListViewModel.fetchCryptocurrencies()
    }
    
    private func startActivityIndicator() {
        self.view.addSubview(activityView)
        activityView.center = self.view.center
        activityView.startAnimating()
    }
    
    private func stopActivityIndicator() {
        activityView.stopAnimating()
        activityView.removeFromSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
