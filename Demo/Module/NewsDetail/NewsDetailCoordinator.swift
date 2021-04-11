//
//  NewsDetailCoordinator.swift
//  Demo
//
//  Created by Ganesh Manickam on 11/04/21.
//  
//

import RxSwift

class NewsDetailCoordinator: BaseCoordinator<Void> {
    
    private let rootViewController: UIViewController
    private let newsDetail: NewsArticleResponse?
    
    init(rootViewController: UIViewController, newsDetail: NewsArticleResponse) {
        self.rootViewController = rootViewController
        self.newsDetail = newsDetail
    }
    
    override func start() throws -> Observable<Void> {
        
        let viewController = NewsDetailViewController()
        let viewModel = NewsDetailViewModel()
        viewController.viewModel = viewModel
        viewController.viewModel.newsDetail = self.newsDetail
        viewController.viewModel.delegate = viewController
        
        bindLifecycle(for: viewController)
        bindViewModel(for: viewModel, vc: viewController)
        rootViewController.pushTo(viewController, animated: true)
        return Observable.empty()
    }
    
}
// MARK: - Bind View controller lifecycle and viewmodel
extension NewsDetailCoordinator {
    /**
     Function to bind lifecycle for the view controller
     - PARAMETER viewController: Instance of View Controller
     */
    func bindLifecycle(for viewController: NewsDetailViewController) {
        
        viewController.rx.viewWillAppear
            .subscribe(onNext: { _ in
                
            })
            .disposed(by: disposeBag)
    }
    
    /**
     Function to bind view model
     - PARAMETER viewModel: Instance of View Model
     - PARAMETER vc: Instance of View Controller
     */
    func bindViewModel(for viewModel: NewsDetailViewModel, vc: NewsDetailViewController) {
    }
}
