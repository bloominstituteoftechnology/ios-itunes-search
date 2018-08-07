//
//  SettingsViewController.swift
//  ios-itunes-search
//
//  Created by De MicheliStefano on 07.08.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func updateSettings(_ sender: Any) {
        searchResultController?.updateSettings(country: countryTextLabel.text, searchLimit: searchLimitTextLabel.text)
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    var searchResultController: SearchResultController?
    
    @IBOutlet weak var countryTextLabel: UITextField!
    @IBOutlet weak var searchLimitTextLabel: UITextField!
    
}
