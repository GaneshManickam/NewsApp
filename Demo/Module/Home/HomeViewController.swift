//
//  HomeViewController.swift
//  Demo
//
//  Created by Ganesh Manickam on 10/04/21.
//  
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

class HomeViewController: UIViewController, UITableViewDelegate {
    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Properties
    let disposeBag = DisposeBag()
    var viewModel: HomeViewModel!
    fileprivate let isLoading = BehaviorRelay<Bool>(value: false)
    let newsArray = BehaviorRelay<[NewsArticleResponse]>(value: [])

    // MARK: - Superview Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
        initRxBinding()
        setupUI()
        initData()
    }

    /**
     Function to intialize the data
     */
    func initData() {
        self.isLoading.accept(true)
        self.viewModel.currentPage = 1
        self.newsArray.accept([])
        self.viewModel.performGetEveythingAPICall()
    }
    
    /**
     Function to register table view
     */
    private func registerTableView() {
        self.tableView.rx.setDelegate(self).disposed(by: self.disposeBag)
        self.tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
        self.tableView.estimatedRowHeight = 300
        self.tableView.rowHeight = UITableView.automaticDimension
    }

}

// MARK: - Binding
extension HomeViewController {
    /**
     Function to initialize Rx binding
     */
    func initRxBinding() {
        isLoading.asObservable()
            .bind { status in
                if status {
                    AppDelegate.startLoading()
                } else {
                    AppDelegate.finishLoading()
                }
            }.disposed(by: disposeBag)
        
        searchBar.rx.searchButtonClicked.asDriver()
            .drive(onNext: { [weak self] in
                self?.searchBar.resignFirstResponder()
                self?.viewModel.query = self?.searchBar?.text ?? ""
                self?.viewModel.currentPage = 1
                self?.newsArray.accept([])
                self?.isLoading.accept(true)
                self?.viewModel.performGetEveythingAPICall()
            }).disposed(by: disposeBag)
        
        newsArray.asObservable().bind(to: tableView.rx.items(cellIdentifier: "NewsTableViewCell", cellType: NewsTableViewCell.self)) { (row, item, cell) in
            cell.updateUIElements(item)
            if row == self.newsArray.value.count-1 && self.viewModel.shouldLoad {
                self.viewModel.performGetEveythingAPICall()
            }
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(NewsArticleResponse.self).subscribe(onNext: { [weak self] item in
            self?.viewModel.redirectToDetail.asObserver().onNext(item)
        }).disposed(by: disposeBag)
    }
    
}

// MARK: - UI Setup
extension HomeViewController {
    /**
     Function to setup ui elements
     */
    func setupUI() {
        
    }
}
// MARK: - ViewModel Delegate
extension HomeViewController: HomeViewModelDelegate {
    func getEverythingSuccessResponse(_ response: Any) {
        self.isLoading.accept(false)
        if let apiResponse = response as? NewsEverythingResponse {
            let articles = apiResponse.articles ?? []
            if !articles.isEmpty {
                viewModel.shouldLoad = true
                viewModel.currentPage += 1
                self.newsArray.append(contentsOf: articles)
            } else {
                viewModel.shouldLoad = false
            }
        }
    }
    
    func getEverythingFailureError(_ error: Error) {
        self.isLoading.accept(false)
        AppDelegate.showToast(message: error.localizedDescription)
    }
}
