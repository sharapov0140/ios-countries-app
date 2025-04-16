//
//  CountriesViewModel.swift
//  Countries
//
//  Created by Sharapov on 4/15/25.
//

import Foundation

protocol CountriesViewModelDelegate: AnyObject {
    func didUpdateCountries(_ countries: [Country])
    func didFailToLoadCountries(error: Error?)
}

/// Simple MVVM approach: fetch data from service, store it, and filter it.
class CountriesViewModel {
    weak var delegate: CountriesViewModelDelegate?

    private let service = CountriesService()

    // Keep all countries plus a filtered version
    private var allCountries: [Country] = []
    private(set) var filteredCountries: [Country] = []

    func loadCountries() {
        service.fetchCountries { [weak self] fetchedList in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.allCountries = fetchedList
                self.filteredCountries = fetchedList
                if fetchedList.isEmpty {
                    self.delegate?.didFailToLoadCountries(error: nil)
                } else {
                    self.delegate?.didUpdateCountries(fetchedList)
                }
            }
        }
    }

    func filter(by query: String) {
        if query.isEmpty {
            filteredCountries = allCountries
        } else {
            let lower = query.lowercased()
            filteredCountries = allCountries.filter {
                $0.name.lowercased().contains(lower) ||
                $0.capital.lowercased().contains(lower)
            }
        }
        delegate?.didUpdateCountries(filteredCountries)
    }
}
