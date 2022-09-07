//
//  CryptoDetailsViewController.swift
//  CryptoApp
//
//  Created by Yunus Emre Koca on 6.09.2022.
//

import UIKit
import RxSwift
import RxCocoa

final class CryptoDetailsViewController: UIViewController {
    
    private let cryptoDetailsViewModel: CryptoDetailsViewModel
    private let bag: DisposeBag
    
    private lazy var isDescriptionLabelExpanded: Bool = false
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var symbolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var readMoreButton: UIButton = {
        let button = UIButton(configuration: UIButton.Configuration.borderless())
        button.setTitle("Read more...", for: .normal)
        button.addTarget(self, action: #selector(readMoreButtonClicked), for: .touchUpInside)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var websiteTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        textView.isScrollEnabled = false
        textView.textAlignment = .center
        textView.dataDetectorTypes = .link
        textView.textDragInteraction?.isEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    init(cryptocurrency: Cryptocurrency) {
        self.cryptoDetailsViewModel = CryptoDetailsViewModel(cryptocurrency: cryptocurrency)
        self.bag = DisposeBag()
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        applyConstraints()
        
        initViewModel()
    }
    
    private func showTheReadMoreButtonIfNeeded() {
        if descriptionLabel.getLineCount() > 3 {
            readMoreButton.isHidden = false
        }
    }
    
    @objc private func readMoreButtonClicked() {
        if isDescriptionLabelExpanded {
            readMoreButton.setTitle("Read more", for: .normal)
            descriptionLabel.numberOfLines = 3
            isDescriptionLabelExpanded = false
        } else {
            readMoreButton.setTitle("Show less", for: .normal)
            descriptionLabel.numberOfLines = 0
            isDescriptionLabelExpanded = true
        }
    }
    
    private func applyConstraints() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(symbolImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(readMoreButton)
        contentView.addSubview(websiteTextView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.9),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            symbolImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 75),
            symbolImageView.heightAnchor.constraint(equalToConstant: 75)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            priceLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            priceLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
            descriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            descriptionLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
        ])
        
        NSLayoutConstraint.activate([
            readMoreButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            readMoreButton.leftAnchor.constraint(equalTo: contentView.leftAnchor),
        ])
        
        NSLayoutConstraint.activate([
            websiteTextView.topAnchor.constraint(equalTo: readMoreButton.bottomAnchor, constant: 15),
            websiteTextView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            websiteTextView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            websiteTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func initViewModel() {
        cryptoDetailsViewModel.coinDescription.subscribe(onNext: { [weak self] coinDescription in
            self?.descriptionLabel.text = coinDescription
            self?.showTheReadMoreButtonIfNeeded()
        }).disposed(by: bag)
        
        cryptoDetailsViewModel.website.subscribe(onNext: { [weak self] website in
            self?.websiteTextView.text = website
        }).disposed(by: bag)
        
        nameLabel.text = cryptoDetailsViewModel.name
        priceLabel.text = cryptoDetailsViewModel.currentPrice
        symbolImageView.kf.setImage(with: cryptoDetailsViewModel.imageURL)
        
        cryptoDetailsViewModel.fetchCryptocurrencyDetails()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
