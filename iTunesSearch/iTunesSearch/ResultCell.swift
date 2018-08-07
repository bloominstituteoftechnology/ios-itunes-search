
import Foundation
import UIKit

class ResultCell: UITableViewCell
{
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var authorLabel: UILabel!
	@IBOutlet weak var countryLabel: UILabel!
	var result:SearchResult! {
		didSet {
			nameLabel.text = result.title
			authorLabel.text = result.creator
			countryLabel.text = result.currency
		}
	}
}
