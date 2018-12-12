import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var segmentSelectorOutlet: UISegmentedControl!
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    
    //let searchResultsController: SearchResultController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarOutlet.delegate = self
    }

    // MARK: - Table view data source

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
    
    func searchBarButtonClicked(_ searchBar: UISearchBar) {
        guard let search = searchBar.text, search.count > 0 else { return }
        
        var resultType: ResultType!
        let index = segmentSelectorOutlet.selectedSegmentIndex
        
        if index == 0 {
            resultType = .software
        } else if index == 1 {
            resultType = .musicTrack
        } else {
            resultType = .movie
        }
        
        SearchResultController.shared.performSearch(with: search, resultType: resultType) { (_) in
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
