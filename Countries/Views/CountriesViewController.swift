import UIKit

class CountriesViewController: UIViewController {

    private let tableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    private let viewModel = CountriesViewModel()

    private var countries: [Country] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Countries"
        view.backgroundColor = .systemBackground

        // Setup Search
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false

        // Table
        tableView.dataSource = self
        tableView.delegate = self

        // IMPORTANT: Use the same reuse identifier "CountryCell"
        tableView.register(CountryCell.self, forCellReuseIdentifier: "CountryCell")

        view.addSubview(tableView)
        tableView.fillSuperview() // Using your anchor extension

        // ViewModel
        viewModel.delegate = self
        viewModel.loadCountries()
    }
}

// MARK: - CountriesViewModelDelegate
extension CountriesViewController: CountriesViewModelDelegate {
    func didUpdateCountries(_ countries: [Country]) {
        // Quick debug check
        print("didUpdateCountries, count = \(countries.count)")
        self.countries = countries
        tableView.reloadData()
    }

    func didFailToLoadCountries(error: Error?) {
        let alert = UIAlertController(title: "Error",
                                      message: "Failed to load countries.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - UISearchResultsUpdating
extension CountriesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text ?? ""
        viewModel.filter(by: text)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension CountriesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection => \(countries.count)")
        return countries.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "CountryCell", for: indexPath
        ) as? CountryCell else {
            return UITableViewCell()
        }

        let country = countries[indexPath.row]
        cell.configure(
            name: country.name,
            region: country.region,
            code: country.code,
            capital: country.capital
        )
        return cell
    }
}
