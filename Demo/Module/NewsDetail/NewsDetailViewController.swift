//
//  NewsDetailViewController.swift
//  Demo
//
//  Created by Ganesh Manickam on 11/04/21.
//  
//

import UIKit
import RxSwift
import RxCocoa

class NewsDetailViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var navigationTitleLabel: UILabel!
    @IBOutlet weak var newsImageView: AdjustableImageView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    
    // MARK: - Properties
    let disposeBag = DisposeBag()
    var viewModel: NewsDetailViewModel!

    // MARK: - Superview Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initRxBinding()
        setupUI()
    }

}

// MARK: - Binding
extension NewsDetailViewController {
    /**
     Function to initialize Rx binding
     */
    func initRxBinding() {
        backButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
    }
    
}

// MARK: - UI Setup
extension NewsDetailViewController {
    /**
     Function to setup ui elements
     */
    func setupUI() {
        self.newsImageView.image = UIImage()
        if let imgUrl = URL(string: viewModel.newsDetail?.urlToImage ?? "") {
            self.newsImageView.kf.setImage(with: imgUrl)
        }
        self.titleLabel.text = viewModel.newsDetail?.title ?? ""
        self.dateLabel.text = viewModel.newsDetail?.publishedAt ?? ""
        self.contentLabel.text = viewModel.newsDetail?.content ?? ""
        self.descriptionLabel.text = viewModel.newsDetail?.descriptionStr ?? ""
        self.baseView.isHidden = false
    }
}
// MARK: - ViewModel Delegate
extension NewsDetailViewController: NewsDetailViewModelDelegate {
    
}
