//
//  CountrySearchViewController.swift
//  SearchCountries
//
//  Created by Chakane Shegog on 1/10/22.
//

import UIKit

class CountrySearch: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    // Country array we use to populate country name, population, capital data
    var countries = [Country]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        loadCountriesData()
    }
    
    func loadCountriesData() {
        Country.getCountryInfo() { (result) in
            switch result {
            case .failure(let networkError):
                print("\(networkError)")
                
            case .success(let data):
                self.countries = data
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let countryDetail = segue.destination as? CountryDetail, let indexPath = collectionView.indexPathsForSelectedItems?.first else {
            fatalError("Check identity inspector")
        }
        let country = countries[indexPath.row]
        countryDetail.country = country
    }
}

// MARK: - Datasource protocol for collection view
extension CountrySearch: UICollectionViewDataSource {
    
    // whats inside the cell?
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "countryCell", for: indexPath) as? CountryCell else {
            fatalError("Error, check reuseIdentityInspector or CellFile")
        }
        let countryInfo = countries[indexPath.row]
        cell.configureCountryInfoCell(for: countryInfo)
        return cell
    }
    
    
    // how many cells?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countries.count
    }
}

// MARK: - Delegate Flow Layout for collection view
extension CountrySearch: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxWidth: CGFloat = UIScreen.main.bounds.size.width
        let itemWidth: CGFloat = maxWidth * 0.5
        return CGSize(width: itemWidth*1.667, height: itemWidth)
    }
    
}
