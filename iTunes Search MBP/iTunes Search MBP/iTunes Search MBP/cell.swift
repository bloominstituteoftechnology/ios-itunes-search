import UIKit


class TableCell: UITableViewCell {
    
    static let reuseIdentifier = "cell"
 
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var creatorLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var softwareLabel: UILabel!
}
