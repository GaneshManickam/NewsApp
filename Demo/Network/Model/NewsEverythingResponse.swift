//
//  NewsEverythingResponse.swift
//  Demo
//
//  Created by Ganesh Manickam on 11/04/21.
//

import Foundation
import Mapper

struct NewsEverythingResponse: Mappable, Codable {
    var status: String?
    var totalResults: Int?
    var articles: [NewsArticleResponse]?

    init(map: Mapper) throws {
        status = map.optionalFrom("status")
        totalResults = map.optionalFrom("totalResults")
        articles = map.optionalFrom("articles")
    }
}

struct NewsArticleResponse: Mappable, Codable {
    var title: String?
    var descriptionStr: String?
    var urlToImage: String?
    var content: String?
    var publishedAt: String?
    
    init(map: Mapper) throws {
        title = map.optionalFrom("title")
        descriptionStr = map.optionalFrom("description")
        urlToImage = map.optionalFrom("urlToImage")
        content = map.optionalFrom("content")
        if let dateStr: String = map.optionalFrom("publishedAt") {
            let dateFormate = DateFormatter()
            dateFormate.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
            if let dateObject = dateFormate.date(from: dateStr) {
                dateFormate.dateFormat = "MMM dd, yyyy hh:mm a"
                publishedAt = dateFormate.string(from: dateObject)
            }
        }
    }
}
