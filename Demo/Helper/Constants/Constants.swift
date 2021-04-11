//
//  Constants.swift
//  Demo
//
//  Created by Ganesh Manickam on 10/04/21.
//
import Foundation

struct Constants {
    
    struct URLs {
        static let base_url = "https://newsapi.org/v2"
    }
    
    struct ApiConstants {
        static let query = "q"
        static let sortedBy = "sortBy"
        static let publishedAt = "publishedAt"
        static let apiKey = "apiKey"
        static let page = "page"
    }
    
    struct ApiPathConstants {
        static let getEverything = "/everything"
    }
    
    struct BundleConstants {
        static let type = "type"
        static let delegate = "delegate"
    }
    
    struct NewsAPIKey {
        // MARK: NewsAPIKey
        static let key = AppDelegate.currentDelegate.secrectKeys.newsAPIKey
    }
}
