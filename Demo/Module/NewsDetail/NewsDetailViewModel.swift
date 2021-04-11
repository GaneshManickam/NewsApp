//
//  NewsDetailViewModel.swift
//  Demo
//
//  Created by Ganesh Manickam on 11/04/21.
//  
//

import RxSwift
import RxCocoa

// MARK: - ViewModel protocols to communicate viewmodel to view controller
protocol NewsDetailViewModelDelegate: class {
}

class NewsDetailViewModel {
    let service = NewsDetailService()
    private var disposeBag = DisposeBag()
    weak var delegate: NewsDetailViewModelDelegate?
    var newsDetail: NewsArticleResponse?
}

extension NewsDetailViewModel {
    
}
