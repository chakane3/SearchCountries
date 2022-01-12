//
//  CountryCell.swift
//  SearchCountries
//
//  Created by Chakane Shegog on 1/11/22.
//

import UIKit

class CountryCell: UICollectionViewCell {
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var countryCapitalLabel: UILabel!
    @IBOutlet weak var countryPopulationLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    @IBOutlet weak var skiesLabel: UILabel!
    @IBOutlet weak var windSpeedDirectionLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 20.0
    }
    
    func configureCountryWeatherCell(for country: WeatherInfo) {
        currentTempLabel.text = "Current temp: \(country.consolidated_weather.the_temp)"
    }
    
    func configureCountryInfoCell(for country: Country) {
        countryName.text = "\(country.name.common)"
        countryCapitalLabel.text = "Capital: \(country.capital?[0] ?? "no capital")"
        countryPopulationLabel.text = "Population: \(country.population) people"

        imageView.getImage(with: country.flags.png) { (result) in
            switch result {
            case .failure(let imageError):
                print("error in getting image: \(imageError)")

            case .success(let data):
                DispatchQueue.main.async {
                    self.imageView.image = data
                }
            }
        }
    }
}
