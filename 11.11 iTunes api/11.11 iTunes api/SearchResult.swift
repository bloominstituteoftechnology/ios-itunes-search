import Foundation

struct SearchResult: Codable {
    var title: String
    var creator: String
    
    enum CodingKeys: String, CodingKey {
        case title: trackName
        case artist: artistName
}
    
struct SearchResults {
    let results: [SearchResult]
    }
}
