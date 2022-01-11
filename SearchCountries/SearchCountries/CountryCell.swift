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
    
    
    func configureCell(for country: Country) {
        countryName.text = country.name.common
//        countryCapitalLabel.text = country.capital[0]
//        countryPopulationLabel.text = "\(country.population)"
//
//        imageView.getImage(with: country.flags.png) { (result) in
//            switch result {
//            case .failure(let imageError):
//                print("error in getting image: \(imageError)")
//
//            case .success(let data):
//                self.imageView.image = data
//            }
//        }
    }
}
