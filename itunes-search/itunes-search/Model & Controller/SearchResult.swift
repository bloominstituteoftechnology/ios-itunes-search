import Foundation
import UIKit


// MARK:- Model
struct SearchResults: Codable {
    var results: [SearchResult]
}

struct SearchResult: Codable {
    let title: String
    let creator: String

    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
        
    }
    
}
