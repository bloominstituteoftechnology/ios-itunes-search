import Foundation

struct SearchResult: Codable {
    let title: String
    let creator: String
    let smallImage: ImageURLs
    let mediumImage: ImageURLs
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
        case smallImage = "artworkUrl60"
        case mediumImage = "artworkUrl100"
        
    }
}

struct ImageURLs: Codable {
    let smallImage: String
    let mediumImage: String
}

struct SearchResults: Codable {
    let results: [SearchResult]
}

