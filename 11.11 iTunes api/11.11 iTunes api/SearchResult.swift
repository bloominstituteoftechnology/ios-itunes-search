import Foundation

struct SearchResults: Codable {
    var title: String
    var creator: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
}

struct ResultsList: Codable {
    let results: [SearchResults]
}
