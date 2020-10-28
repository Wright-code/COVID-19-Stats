//
//  ViewController.swift
//  COVID-19 Stats
//
//  Created by Harry Wright on 12/10/2020.
//

import UIKit

class ViewController: UIViewController, CovidStatsDelegate {
    
    //MARK: View Controller Variables
    var usableCountryArray = [""]
    var numberOfCountries = 5
    var covidStatsManager = CovidStatsManager()
    
    //MARK: Likned IBOutlets
    @IBOutlet weak var countryPicker: UIPickerView!
    @IBOutlet weak var totalConfirmedCasesLabel: UILabel!
    @IBOutlet weak var totalConfirmedDeathsLabel: UILabel!
    @IBOutlet weak var totalConfirmedRecoveriesLabel: UILabel!
    @IBOutlet weak var additionalCases: UILabel!
    @IBOutlet weak var lastUpdatedLabel: UILabel!
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        countryPicker.layer.cornerRadius = 20
        covidStatsManager.delegate = self
        
        //Stats update on app loading and populate to the first value on the picker wheel
        covidStatsManager.performRequests(url: covidStatsManager.url, country: 0)
    }
    
    //MARK: Called by StatsManager When Statistics Have Populated
    func didUpdateCovidStats(stats: CovidStatsModel) {
        DispatchQueue.main.async {
            self.totalConfirmedCasesLabel.text = stats.totalConfirmedString
            self.totalConfirmedDeathsLabel.text = stats.totalDeathsString
            self.totalConfirmedRecoveriesLabel.text = stats.totalRecoveredString
            self.additionalCases.text = "+\(stats.newConfirmedString)"
            self.lastUpdatedLabel.text = "Last Updated: \(stats.simpleDay).\(stats.simpleMonth).\(stats.simpleYear)"
            if stats.newConfirmed == 0 {
                self.additionalCases.backgroundColor = UIColor.systemGreen
            } else {
                self.additionalCases.backgroundColor = UIColor.systemRed
            }
            self.usableCountryArray = stats.countries
            self.numberOfCountries = stats.countries.count
            
            //Country picker delegate denoted here to allow the stats to populate before pickerView updates
            self.countryPicker.delegate = self
        }
    }
    
    //MARK: Error Handling
    func didFailWithError(_ error: Error) {
        print(error)
    }

}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    //MARK: Number of Columns
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //MARK: Number of Rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberOfCountries
    }
    
    //MARK: Populate Titles with Statistic Data
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return usableCountryArray[row]
    }
    
    //MARK: Updates Data Based on Picker View Row Selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        covidStatsManager.performRequests(url: covidStatsManager.url, country: row)
        DispatchQueue.main.async {
//            self.totalConfirmedCasesLabel.text = "Loading..."
//            self.totalConfirmedDeathsLabel.text = "Loading..."
//            self.totalConfirmedRecoveriesLabel.text = "Loading..."
//            self.additionalCases.text = "Loading..."
        }
    }
    
}
