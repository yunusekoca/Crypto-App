//
//  CryptoListViewModel.swift
//  CryptoApp
//
//  Created by Yunus Emre Koca on 5.09.2022.
//

import Alamofire
import RxSwift
import RxCocoa

final class CryptoListViewModel {
    
    lazy var cryptocurrencies = BehaviorSubject(value: [Cryptocurrency]())
    lazy var error = PublishSubject<Error>()
    lazy var isLoading = BehaviorRelay<Bool>(value: true)
    
    func fetchCryptocurrencies() {
        guard let url = URL(string: (Constants.baseURL + Constants.coinsListEndPoint)) else {
            self.error.onNext(ServiceError.urlError)
            return
        }
        isLoading.accept(true)
        AF.request(url, method: .get).responseDecodable(of:[Cryptocurrency].self) { [weak self] response in
            switch response.result {
            case .success(let cryptocurrencies):
                self?.cryptocurrencies.onNext(cryptocurrencies)
                self?.isLoading.accept(false)
            case .failure(_):
                self?.isLoading.accept(false)
                self?.error.onNext(ServiceError.connectionError)
            }
        }
    }
}
