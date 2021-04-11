//
//  HomeService.swift
//  Demo
//
//  Created by Ganesh Manickam on 10/04/21.
//  
//

import Foundation
import RxSwift

class HomeService {
    private let facade = HTTPFacade<NetworkTarget>()
    private let disposeBag = DisposeBag()
}

extension HomeService {
    /**
     Function to perform get everything api call
     - PARAMETER parameters: Dictionary to hold api parameters
     - RETURNS: API's success or failure callback
     */
    func getEverything(parameters: [String: Any]) -> Single<Data> {
        return Single.create { observer in
            let target = NetworkTarget.getEverything(parameter: parameters)
            self.facade.request(target: target).subscribe(onSuccess: { data in
                observer(.success(data))
            }, onError: { error in
                observer(.error(error))
            }).disposed(by: self.disposeBag)
            return Disposables.create {}
        }
    }
}
