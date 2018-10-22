import Foundation
import UIKit


// MARK:- Model
struct SearchResults: Codable {
    var results: [SearchResult]?
}

struct SearchResult: Codable {
    let title: String
    let creator: String
    let albumTitle: String?
    let imageUrl: String?
    let appImageUrl: String?
    let appStoreCategory: String?
    let screenshotUrls: [String]?
    let itunesUrl: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
        case albumTitle = "collectionName"
        case imageUrl = "artworkUrl100"
        case appImageUrl = "artworkUrl512"
        case appStoreCategory = "primaryGenreName"
        case screenshotUrls = "screenshotUrls"
        case itunesUrl = "trackViewUrl"
    }
    
}
