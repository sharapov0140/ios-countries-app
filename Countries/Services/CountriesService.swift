//
//  CountriesService.swift
//  Countries
//
//  Created by Sharapov on 4/15/25.
//

import Foundation

class CountriesService {
    // Hardcode the JSON URL from the assignment instructions:
    private let countriesURL = URL(string:
     "https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json"
    )!

    func fetchCountries(completion: @escaping ([Country]) -> Void) {
        let task = URLSession.shared.dataTask(with: countriesURL) { data, _, error in
            guard let data = data, error == nil else {
                completion([])
                return
            }
            do {
                // It's an array of Country objects
                // Possibly the top-level is `{"[": <some array>}`,
                // but from the snippet it looks like it’s a top-level array.
                let decoded = try JSONDecoder().decode([Country].self, from: data)
                completion(decoded)
            } catch {
                completion([])
            }
        }
        task.resume()
    }
}

