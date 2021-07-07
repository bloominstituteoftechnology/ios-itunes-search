
import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var segmented: UISegmentedControl!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let searchResultsController = SearchResultController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // searchBar.delegate
       
    }
    
    func searchBarSearchButtonClicked() {
        
        guard let search = searchBar.text, searchBar.text != nil else {return}
        
        
        
        
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return SearchResultController().searchResults.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.reuseIdentifier, for: indexPath) as? SearchResultTableViewCell else {
            fatalError("no such cell")
        }
        
        let result = SearchResultController().searchResults

        SearchResultTableViewCell().title.text = result[indexPath.row].title
        SearchResultTableViewCell().creator.text = result[indexPath.row].creator

        return cell
    }
}
