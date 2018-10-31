
import UIKit

class SearchResultsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      searchBar.delegate = self
    }

    func searchBarButtonClicked(_ searchBar: UISearchBar) {
        guard let search = searchBar.text, search.count > 0 else { return }
        
        var resultType: ResultType!
        let index = segmentedControl.selectedSegmentIndex
        
        if index == 0 {
            resultType = .software
        } else if index == 1 {
            resultType = .musicTrack
        } else {
            resultType = .movie
        }
        
        SearchResultContoller.shared.performSearch(with: search, resultType: resultType) { (_) in
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
    }
}

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return SearchResultContoller.shared.searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "iTunesCell", for: indexPath)

        let searchResult = SearchResultContoller.shared.searchResults[indexPath.row]
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.creator

        return cell
    }

    
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
}
