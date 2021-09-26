//
//  APIClient.swift
//  swapi-ios
//
//  Created by Priscilla Ip on 2021-09-26.
//

import Foundation

struct APIClient {

    private let basePeopleEndpoint = "https://swapi.dev/api/people"

    func fetch<T: Decodable>(url: URL?, dataType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {

        var request: URL = URL(string: self.basePeopleEndpoint)!

        if let url = url {
            request = url
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let response = response as? HTTPURLResponse else {
                print("Empty response")
                return
            }

            print("Response status code: \(response.statusCode)")

            guard let data = data else {
                print("Empty data")
                return
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            do {
                let jsonData = try decoder.decode(dataType.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }

            } catch let jsonError {
                completion(.failure(jsonError))
                print("Error: \(jsonError.localizedDescription)")
            }

        }.resume()
    }
}
