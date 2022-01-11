//
//  Weather.swift
//  SearchCountries
//
//  Created by Chakane Shegog on 1/10/22.
//

import Foundation

// MARK: - (struct) Get weatherID from user query (country will only show capital's weather)
struct WeatherID: Codable {
    let title: String
    let woeid: Int
}

extension WeatherID {
    static func getWeatherID(for weatherQuery: String, completion: @escaping (Result<WeatherID, NetworkError>) -> ()) {
        let weatherQuery = weatherQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let endpoint = "https://www.metaweather.com/api/location/search/?query=\(weatherQuery)"
        
        
        // create our request input for our NetworkRequest()
        guard let url = URL(string: endpoint) else {
            completion(.failure(.badURL(endpoint)))
            return
        }
        let request = URLRequest(url: url)
        
        NetworkRequest.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let networkError):
                completion(.failure(.networkClientError(networkError)))
                
            case .success(let data):
                do {
                    let weatherID = try JSONDecoder().decode(WeatherID.self, from: data)
                    completion(.success(weatherID))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}

// MARK: - (struct) Get Weather from weatherID
struct WeatherInfo: Codable {
    let time: String
    let sun_rise: String
    let sun_set: String
    let title: String
    let timezone: String
    let consolidated_weather: [ConsolidatedWeather]
}

struct ConsolidatedWeather: Codable {
    let weather_state_name: String
    let min_temp: Double
    let max_temp: Double
    let the_temp: Double
    let wind_speed: Double
    let wind_direction_compass: String
    let visibility: Double
}

extension WeatherInfo {
    
}



