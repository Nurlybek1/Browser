//
//  CharactersVC.swift
//  Assignment4
//
//  Created by Nurlybek Saktagan on 04.12.2021.
//

import UIKit
import WebKit
class CharactersVC: UITableViewController {
    
    var web_view: WKWebView?
    var text1: UITextField?
    var text2: UITextField?
    var str1: String?
    var str2: String?
    var isFavourite = false
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    private var characters: [Characters] =
        [
            Characters(name: "Google", webView: "https://www.google.com"),
            Characters(name: "Apple", webView: "https://www.apple.com"),
            Characters(name: "Youtube", webView: "https://www.youtube.com")
    ]
    
    private var favCharacters: [Characters] = []
    
    @IBAction func pressedSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            isFavourite = false
        } else {
            isFavourite = true
        }
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Characters"
        
    }
    
    @IBAction func showAlert(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add website", message: "Fill all the fields", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter title"
            self.text1 = textField
        })
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter url"
            self.text2 = textField
        })
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
            let n = Characters(name: self.text1?.text, webView: self.text2?.text)
            self.characters.append(n)
            self.tableView.reloadData()
        }))
        self.present(alert, animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return isFavourite ? favCharacters.count : characters.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        let character = isFavourite ? favCharacters[indexPath.row] : characters[indexPath.row]
        cell.textLabel?.text = character.name
        // Configure the cell...

        return cell
    }

    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let navCan = segue.destination as? UINavigationController {
                if let destination = navCan.visibleViewController as? InfoVC {
                    if let row = tableView.indexPathForSelectedRow?.row {
                        destination.navigationItem.title = characters[row].name
                        let myURL = URL(string: characters[row].webView!)
                        destination.url = myURL
                        destination.name = characters[row].name ?? ""
                        destination.myProtocol = self
                    }
                }
            }
        }
    }
    
}
extension CharactersVC: CharactersProtocol {
    func addFavourite(name: String, webView: String) {
        let character = Characters(name: name, webView: webView)
        favCharacters.append(character)
        tableView.reloadData()
    }
    
    
}
