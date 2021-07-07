
import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var segmented: UISegmentedControl!
    
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
   var searchResultController = SearchResultController()
    
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            //        guard let searchTerm = searchBar.text, !searchTerm.isEmpty
            //            else {return}
            
            guard let searchTerm = searchBar.text, searchTerm.count > 0 else {return}
            
            var resultType: ResultType!
            let index = searchBar.selectedScopeButtonIndex
            
            if index == 0 {
                resultType = .software
                
            } else if index == 1 {
                resultType = .musicTrack
                
            } else if index == 2 {
                resultType = .movie
            }else { return }
            searchResultController.performSearch(with: searchTerm, resultType: resultType) { (_) in
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return searchResultController.searchResults.count
        }
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            let searchResult = searchResultController.searchResults[indexPath.row]
            cell.textLabel?.text = searchResult.title
            cell.detailTextLabel?.text = searchResult.creator
            
            return cell
        }
        
}
