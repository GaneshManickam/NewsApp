//
//  HomeViewModel.swift
//  Demo
//
//  Created by Ganesh Manickam on 10/04/21.
//  
//

import RxSwift
import RxCocoa

// MARK: - ViewModel protocols to communicate viewmodel to view controller
protocol HomeViewModelDelegate: class {
    func getEverythingSuccessResponse(_ response: Any)
    func getEverythingFailureError(_ error: Error)
}

class HomeViewModel {
    let service = HomeService()
    private var disposeBag = DisposeBag()
    weak var delegate: HomeViewModelDelegate?
    var currentPage: Int = 1
    var shouldLoad: Bool = true
    var query: String = "tesla"
    let redirectToDetail = PublishSubject<NewsArticleResponse>()
}
// MARK: API Call
extension HomeViewModel {
    
    /**
     Function to perform get everything api call
     */
    func performGetEveythingAPICall() {
        let parameter: [String: Any] = [
            Constants.ApiConstants.query: self.query,
            Constants.ApiConstants.apiKey: Constants.NewsAPIKey.key,
            Constants.ApiConstants.sortedBy: Constants.ApiConstants.publishedAt,
            Constants.ApiConstants.page: self.currentPage
        ]
        self.getEverything(parameters: parameter)
    }
    
    /**
     Function to perform get everything api call
     - PARAMETER parameters: Dictonary value to hold api parameters
     */
    func getEverything(parameters: [String: Any]) {
        service.getEverything(parameters: parameters).subscribe(onSuccess: { data in
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                if let JSON: NSDictionary = json as? NSDictionary {
                    let response = NewsEverythingResponse.from(JSON)!
                    print(response)
                    self.delegate?.getEverythingSuccessResponse(response)
                }
            } catch {}
        }, onError: { error in
            self.delegate?.getEverythingFailureError(error)
        }).disposed(by: disposeBag)
    }
}
