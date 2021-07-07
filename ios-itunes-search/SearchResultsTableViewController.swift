import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //unwrapping to say if the text is not empty allow to search if empty return
        guard let search = searchBar.text, search.count > 0 else {return}
    
        var resultType: ResultType! //forces result type to be of result type
        let index = segmentedControl.selectedSegmentIndex
        
        //if in the segment control the index is 0 that returns apps
        if index == 0 {
            resultType = .software
        
        // if in the segment control the index is 1 that returns music
        } else if index == 1{
            resultType = .musicTrack
        
        // otherwise it returns movies
        } else {
            resultType = .movie
        }
        //singleton is called to search for the result type
        SearchResultController.shared.performSearch(with: search, resultType: resultType) { (_) in
            
            // once the search has been made the data needs to load to the main thread so the user can see the results
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SearchResultController.shared.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultsCell", for: indexPath)

        let searchResult = SearchResultController.shared.searchResults[indexPath.row]
        
            cell.textLabel?.text = searchResult.title
            cell.detailTextLabel?.text = searchResult.creator

        return cell
    }
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var searchBar: UISearchBar!
    

}
