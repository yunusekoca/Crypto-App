//
//  CryptoTableViewCell.swift
//  CryptoApp
//
//  Created by Yunus Emre Koca on 5.09.2022.
//

import UIKit
import Kingfisher

final class CryptoTableViewCell: UITableViewCell {
    
    static let identifier = "CryptoTableViewCell"
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private lazy var symbolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func applyConstraints() {
        addSubview(stackView)
        addSubview(symbolImageView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            symbolImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            symbolImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            symbolImageView.widthAnchor.constraint(equalToConstant: 50),
            symbolImageView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: symbolImageView.rightAnchor, constant: 15),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 60)
        ])
    }
    
    func configureCryptoCell(with cryptocurrencyVM: CryptocurrencyViewModel) {
        priceLabel.text = cryptocurrencyVM.currentPriceUSD
        nameLabel.text = cryptocurrencyVM.name
        symbolImageView.kf.setImage(with: cryptocurrencyVM.imageURL)
    }
}
