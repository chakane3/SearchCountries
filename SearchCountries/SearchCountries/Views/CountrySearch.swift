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
    
    
    // CountryInfo Array we use to populate data from user query
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
}

// MARK: - Datasource protocol for collection view
extension CountrySearch: UICollectionViewDataSource {
    
    // whats inside the cell?
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "countryCell", for: indexPath) as? CountryCell else {
            fatalError("Error, check reuseIdentityInspector or CellFile")
        }
        
        let country = countries[indexPath.row]
        cell.configureCell(for: country)
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
        let itemWidth: CGFloat = maxWidth * 0.7
        return CGSize(width: itemWidth+32.0, height: itemWidth)
    }
    
}
