//
//  SettingsViewController.swift
//  iTunes Search
//
//  Created by Dillon McElhinney on 9/11/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var numberOfResultsSlider: UISlider!
    @IBOutlet weak var numberOfResultsToDisplayLabel: UILabel!
    @IBOutlet weak var countryCodeSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if UserDefaults.standard.integer(forKey: SettingsKeys.numberOfResultsKey.rawValue) == 0 {
            UserDefaults.standard.set(40, forKey: SettingsKeys.numberOfResultsKey.rawValue)
        }
        
        if UserDefaults.standard.string(forKey: SettingsKeys.countryCodeKey.rawValue) == nil {
            UserDefaults.standard.set(CountryCode.unitedStates.rawValue, forKey: SettingsKeys.countryCodeKey.rawValue)
        }
        
        numberOfResultsSlider.value = UserDefaults.standard.float(forKey: SettingsKeys.numberOfResultsKey.rawValue)
        
        switch UserDefaults.standard.string(forKey: SettingsKeys.countryCodeKey.rawValue) {
        case "US": countryCodeSegmentedControl.selectedSegmentIndex = 0
        case "GB": countryCodeSegmentedControl.selectedSegmentIndex = 1
        case "JP": countryCodeSegmentedControl.selectedSegmentIndex = 2
        default: break
        }
        
        updateViews()
    }
    
    @IBAction func changeNumber(_ sender: UISlider) {
        UserDefaults.standard.set(Int(sender.value), forKey: SettingsKeys.numberOfResultsKey.rawValue)
        updateViews()
    }
    
    @IBAction func changeCountry(_ sender: UISegmentedControl) {
        switch countryCodeSegmentedControl.selectedSegmentIndex {
        case 0:
            UserDefaults.standard.set(CountryCode.unitedStates.rawValue, forKey: SettingsKeys.countryCodeKey.rawValue)
        case 1:
            UserDefaults.standard.set(CountryCode.greatBritain.rawValue, forKey: SettingsKeys.countryCodeKey.rawValue)
        case 2:
            UserDefaults.standard.set(CountryCode.japan.rawValue, forKey: SettingsKeys.countryCodeKey.rawValue)
        default: break
        }

    }

    private func updateViews() {
        let numberOfResultsToDisplay = UserDefaults.standard.integer(forKey: SettingsKeys.numberOfResultsKey.rawValue)
        numberOfResultsToDisplayLabel.text = "Number of Results to Display: \(numberOfResultsToDisplay)"
    }
}
