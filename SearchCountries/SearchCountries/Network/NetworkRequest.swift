//
//  NetworkRequest.swift
//  SearchCountries
//
//  Created by Chakane Shegog on 1/10/22.
//

import Foundation

public class NetworkRequest {
    // a shared instance of our class
    public static let shared = NetworkRequest()
    
    // enforces singleton design
    private var urlSession: URLSession
    private init() {
        urlSession = URLSession(configuration: .default)
    }
    
    // Sets up URLSession's dataTask
    // input is a URLRequest (via URL))
    // output is either data or an error
    public func performDataTask(with request: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> ()) {
        let dataTask = urlSession.dataTask(with: request) { (data, response, error) in
            
            
            // check for our network client error
            if let error = error {
                completion(.failure(.networkClientError(error)))
                return
            }
            
            // downcast URLResponse (response) to HTTPURLResponse to get access to the statusCode property on HTTPURLResponse
            guard let urlResponse = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }
            
            // unwrap the data object
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            // validate that the status code is in the 200 range
            switch urlResponse.statusCode {
            case 200...299: break
            default:
                completion(.failure(.badStatusCode(urlResponse.statusCode)))
                return
            }
            completion(.success(data))
        }
        dataTask.resume()
    }
}


// All the possible things that can go wrong in our app
public enum NetworkError: Error, CustomStringConvertible {
    case badURL(String)
    case decodingError(Error)
    case badMimeType(String)
    case networkClientError(Error)
    case noResponse
    case badStatusCode(Int)
    case noData
    
    public var description: String {
        switch self {
        case .badURL(let url):
            return "\(url) is a bad url"
            
        case .decodingError(let error):
            return "\(error)"
            
        case .badMimeType(let mimeType):
            return "Found a \(mimeType) mimeType"
            
        case .networkClientError(let error):
            return "network error: \(error)"
            
        case .noResponse:
            return "no response was returned from the API"
            
        case .badStatusCode(let statusCode):
            return "Bad status code: \(statusCode) was returned from the API"
            
        case .noData:
            return "no data was returned from the API"
        }
    }
}


