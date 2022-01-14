//
//  CountryDetail.swift
//  SearchCountries
//
//  Created by Chakane Shegog on 1/10/22.
//

import UIKit

class CountryDetail: UIViewController {
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var conversionLabel: UILabel!
    
    @IBOutlet weak var currentTimeLabel: UILabel!
    
    var country: Country?
    var countryWeatherID: [WeatherID]?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        print(country?.capital?.first ?? "no ID")
        getCountryWeatherID(for: country?.capital?.first ?? "no ID")
        print(countryWeatherID)
        
    }
    
    func updateUI() {
        capitalLabel.text = "Capital: \(country?.capital?.first ?? "no capital")"
        populationLabel.text = "Population: \(country?.population ?? 0)"
        
        flagImage.getImage(with: country?.flags.png ?? "no img") { (result) in
            switch result {
            case .failure(let networkError):
                print("\(networkError)")
            case .success(let data):
                DispatchQueue.main.async {
                    self.flagImage.image = data
                }
            }
        }
    }
    
    func getCountryWeatherID(for country: String) {
        WeatherID.getWeatherID(for: country) { (result) in
            switch result {
            case .failure(let networkError):
                print("NetworkError: \(networkError)")
                
            case .success(let data):
                self.countryWeatherID = data
                print("This one sir: \(data)")
            }
        }
    }

    @IBAction func convertButtonPressed(_ sender: Any) {
    }
}
