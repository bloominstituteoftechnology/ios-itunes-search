
import Foundation
import UIKit

struct SearchResult: Codable
{
	var title:String
	var creator:String
	var currency:String

	enum CodingKeys: String, CodingKey
	{
		case title = "trackName"
		case creator = "artistName"
		case currency
	}
}
