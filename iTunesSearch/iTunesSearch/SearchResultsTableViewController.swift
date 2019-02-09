import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {return}
        
        var resultType: ResultType!
        let index = segmentedControl.selectedSegmentIndex
        
        if index == 0 {
            resultType = .software
            
        } else if index == 1 {
            resultType = .musicTrack
            
        } else {
            resultType = .movie
        }
        SearchResultController.shared.performSearch(searchTerm: searchTerm, resultType: resultType)  { (_) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    //tableview funcs
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SearchResultController.shared.searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let searchResult = SearchResultController.shared.searchResults[indexPath.row]
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.creator
        
        guard let url = URL(string: searchResult.smallImage),
            let imageData = try? Data(contentsOf: url) else {return cell}

        cell.imageView?.image = UIImage(data: imageData)
        
        return cell
        
    }
    
    //segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? DetailViewController,
            let indexPath = tableView.indexPathForSelectedRow else {return}
        
        let searchResult = SearchResultController.shared.searchResult(at: indexPath)
        destination.searchResult = searchResult
    }
}

