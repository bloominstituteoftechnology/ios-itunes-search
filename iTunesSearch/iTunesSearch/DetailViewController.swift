import UIKit

class DetailViewController: UIViewController {

    var searchResult: SearchResult?
    
    @IBOutlet weak var artworkView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var creatorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        guard let searchResult = searchResult else {return}
        
        titleLabel.text = searchResult.title
        creatorLabel.text = searchResult.creator
        
        guard let url = URL(string: searchResult.mediumImage.artworkUrl100),
            let imageData = try? Data(contentsOf: url) else {return}
        
        artworkView.image = UIImage(data: imageData)
    }
}
