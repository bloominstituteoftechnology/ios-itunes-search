import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    @IBOutlet weak var selectorOutlet: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBarOutlet.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SearchResultController.shared.searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let searchResult = SearchResultController.shared.searchResults[indexPath.row]
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.creator
        
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let search = searchBar.text, search.count > 0 else { return }
        
        var resultType: ResultType!
        let index = selectorOutlet.selectedSegmentIndex
        
        if index == 0 {
            resultType = .software
            
            
            
            
        } else if index == 1 {
            resultType = .musicTrack
            
            
            
        } else if index == 2 {
            resultType = .movie
            
        }
        
        SearchResultController.shared.performSearch(searchTerm: search, resultType: resultType) { (_) in
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
