//
//  CryptoDetailsViewModel.swift
//  CryptoApp
//
//  Created by Yunus Emre Koca on 6.09.2022.
//

import Alamofire
import RxSwift
import RxCocoa

final class CryptoDetailsViewModel {
    
    private let cryptocurrency: Cryptocurrency
    
    lazy var coinDescription = BehaviorSubject<String?>(value: "")
    lazy var website = BehaviorSubject<String?>(value: "")
    
    init(cryptocurrency: Cryptocurrency) {
        self.cryptocurrency = cryptocurrency
    }
    
    var name: String {
        let name = cryptocurrency.name
        let symbol = cryptocurrency.symbol.uppercased()
        return name + " (\(symbol))"
    }
    
    var imageURL: URL? {
        guard let url = URL(string: cryptocurrency.image) else { return nil }
        return url
    }
    
    var currentPrice: String? {
        return String(describing: cryptocurrency.currentPrice ) + " $"
    }
    
    func fetchCryptocurrencyDetails() {
        guard let url = URL(string: "\(Constants.baseURL + Constants.cryptocurrencyDetailsEndPoint + cryptocurrency.id)") else { return }
        AF.request(url, method: .get).responseDecodable(of: CryptoDetails.self) { [weak self] response in
            switch response.result {
            case .success(let cryptoDetails):
                self?.coinDescription.onNext(cryptoDetails.description?.en?.removeHTMLTags())
                self?.website.onNext(cryptoDetails.links?.homepage?.first)
            case .failure(_):
                print(ServiceError.connectionError)
            }
        }
    }
}
