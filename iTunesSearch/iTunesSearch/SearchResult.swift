import Foundation

struct SearchResult: Codable {
    let title: String
    let creator: String
    let smallImage: String
    let mediumImage: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
        case smallImage = "artworkUrl60"
        case mediumImage = "artworkUrl100"
        
    }
}


struct SearchResults: Codable {
    let results: [SearchResult]
}

