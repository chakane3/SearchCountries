//
//  UIImageView+Extension.swift
//  SearchCountries
//
//  Created by Chakane Shegog on 1/10/22.
//

import Foundation
import UIKit

// This extension on UIImageView to have it implement our URLSession wrapper class
extension UIImageView {
    func getImage(with urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> ()) {
        
        // Implement a subview for UIActivityIndicatorView to indicate to the user that a download is in progress
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .orange
        activityIndicator.startAnimating()
        activityIndicator.center = center
        addSubview(activityIndicator)
        
        
        // create our request input for our NetworkRequest()
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL(urlString)))
            return
        }
        let request = URLRequest(url: url)
        
        
        // perform our data task
        NetworkRequest.shared.performDataTask(with: request) { [weak activityIndicator] (result) in
            DispatchQueue.main.async {
                activityIndicator?.stopAnimating()
            }
            switch result {
            case .failure(let networkError):
                completion(.failure(.networkClientError(networkError)))
                
            case .success(let data):
                if let image = UIImage(data: data) {
                    
                    // capture data
                    completion(.success(image))
                }
            }
        }
    }
}
