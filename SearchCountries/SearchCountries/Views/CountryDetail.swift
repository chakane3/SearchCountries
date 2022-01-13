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
    
    var country: Country?
    var countryWeatherID: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        getCountryWeatherID(for: country?.capital?[0] ?? "no ID")
        print(countryWeatherID)
    }
    
    func getCountryWeatherID(for country: String) {
        WeatherID.getWeatherID(for: country) { (result) in
            switch result {
            case .failure(let networkError):
                print("NetworkError: \(networkError)")
            case .success(let data):
                self.countryWeatherID = data
            }
        }
    }

    @IBAction func convertButtonPressed(_ sender: Any) {
    }
}
