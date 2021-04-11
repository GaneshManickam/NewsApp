//
//  HomeCoordinator.swift
//  Demo
//
//  Created by Ganesh Manickam on 10/04/21.
//  
//

import RxSwift

class HomeCoordinator: BaseCoordinator<Void> {
    
    private let rootViewController: UIViewController
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start() throws -> Observable<Void> {
        
        let viewController = HomeViewController()
        let viewModel = HomeViewModel()
        viewController.viewModel = viewModel
        viewController.viewModel.delegate = viewController
        
        bindLifecycle(for: viewController)
        bindViewModel(for: viewModel, vc: viewController)
        rootViewController.pushTo(viewController, animated: true)
        return Observable.empty()
    }
    
}
// MARK: - Bind View controller lifecycle and viewmodel
extension HomeCoordinator {
    /**
     Function to bind lifecycle for the view controller
     - PARAMETER viewController: Instance of View Controller
     */
    func bindLifecycle(for viewController: HomeViewController) {
        
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
    func bindViewModel(for viewModel: HomeViewModel, vc: HomeViewController) {
        
        viewModel.redirectToDetail.asObserver().subscribe(onNext: { [weak self] (newsDetail) in
            self?.redirectToNewsDetail(on: vc, newsDetail: newsDetail)
        }).disposed(by: disposeBag)
    }
}

extension HomeCoordinator {
    /**
     Function to redirect to news detail
     - PARAMETER vc: Instance of `UIViewController`
     */
    private func redirectToNewsDetail(on vc: UIViewController, newsDetail: NewsArticleResponse) {
        let coordinator = NewsDetailCoordinator(rootViewController: vc, newsDetail: newsDetail)
       self.coordinate(to: coordinator)
    }
}
