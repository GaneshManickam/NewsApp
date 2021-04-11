//
//  NewsTableViewCell.swift
//  Demo
//
//  Created by Ganesh Manickam on 10/04/21.
//

import UIKit
import Kingfisher

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension NewsTableViewCell {
    /**
     Function to setup ui
     */
    fileprivate func setupUI() {
        self.newsImageView.layer.cornerRadius = 4
        self.newsImageView.clipsToBounds = true
    }
    
    /**
     Function to update UI elements
     - PARAMETER data: Instance of `NewsArticleResponse`
     */
    func updateUIElements(_ data: NewsArticleResponse) {
        self.titleLabel.text = data.title ?? ""
        self.dateLabel.text = data.publishedAt ?? ""
        self.subtitleLabel.text = data.descriptionStr ?? ""
        self.newsImageView.image = UIImage()
        if let imgUrl = URL(string: data.urlToImage ?? "") {
            self.newsImageView.kf.setImage(with: imgUrl)
        }
    }
}
