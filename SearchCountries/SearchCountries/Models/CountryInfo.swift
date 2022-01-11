//
//  CountryInfo.swift
//  SearchCountries
//
//  Created by Chakane Shegog on 1/10/22.
//

import Foundation

// MARK: - Get country info

struct Country: Codable {
    let name: NameInfo
}

struct NameInfo: Codable {
    let common: String  // this name will be used to get our flag image
    let official: String
}


extension Country {
    static func getCountryInfo(completion: @escaping (Result<[Country], NetworkError>) -> ()) {
        let endpoint = "https://restcountries.com/v3.1/all"
        
        // create a URLRequest instance
        guard let url = URL(string: endpoint) else {
            completion(.failure(.badURL(endpoint)))
            return
        }
        let request = URLRequest(url: url)
        
        
        // Perform our network request
        NetworkRequest.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let networkError):
                completion(.failure(.networkClientError(networkError)))
            case .success(let data):
                
                // decode our json
                do {
                    let countryInfo = try JSONDecoder().decode([Country].self, from: data)
                    completion(.success(countryInfo))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
