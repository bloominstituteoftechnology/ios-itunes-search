import Foundation

struct SearchResult: Codable {
    let title: String //trackName
    let creator: String //artistName
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case artist = "artistName"
        
    }
    
    struct SearchResults {
        let results: [SearchResults]
    }
    
    
}
