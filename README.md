# Countries Project Documentation

## Overview

This iOS application demonstrates how to:

* **Fetch** a list of countries from a remote JSON endpoint.
* **Display** each country in a table view, showing:
    * A top line with `[Name, Region]` pinned to the left.
    * The `[Code]` pinned to the right on the same line.
    * The `[Capital]` pinned below the name/region.
* **Filter** the list of countries,capitals in real-time using a search bar.
* Support modern iOS features like **dynamic type** and **device rotation**.
* Utilize common design patterns like **MVVM** (Model-View-ViewModel).

---

## 1. Goal & Requirements

The primary goals and requirements for this application are:

1.  **Retrieve Data:** Fetch country data from the following JSON endpoint:
    ```
    [https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json](https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json)
    ```
2.  **Display Data:** Present the countries in a vertically scrolling table (`UITableView`). Each cell must display:
    * `[Name, Region]` aligned to the left.
    * `[Code]` aligned to the right, on the same conceptual line as Name/Region.
    * `[Capital]` on a line below the Name/Region.
3.  **Search Functionality:** Implement searching/filtering by country `Name` or `Capital` using a `UISearchController`.
4.  **Layout Constraint:** Ensure the `[Code]` is always pinned to the right edge and is never truncated or overlapped by a long `[Name, Region]`. The `[Name, Region]` text should wrap if necessary.
5.  **Framework:** Use Apple's **UIKit** framework (not SwiftUI).

---

## 2. Directory Structure

The project follows a standard MVVM structure:

* **Models/Country:** Defines the `Country` struct matching the JSON structure.
* **Services/CountriesService:** Responsible for network requests to fetch the country data.
* **ViewModels/CountriesViewModel:** Acts as the bridge between the Model (data) and the View. It fetches, stores, filters data, and prepares it for display.
* **Views/CountriesViewController:** The main view controller containing the `UITableView` and `UISearchController`. It observes the ViewModel for data updates.
* **Views/CountryCell:** A custom `UITableViewCell` implementing the specific layout requirements using AutoLayout.
* **Helper/UIViewLayout:** Contains extensions for simplifying AutoLayout constraint creation (e.g., `fillSuperview`).

---

## 3. Flow of the App

1.  **Initialization:** `SceneDelegate` sets up the main window and embeds `CountriesViewController` within a `UINavigationController`.
2.  **View Loads:** `CountriesViewController`'s `viewDidLoad` method is called.
    * It configures the `UITableView` and `UISearchController`.
    * It sets itself as the delegate for the `CountriesViewModel`.
    * It calls `viewModel.loadCountries()` to initiate the data fetching process.
3.  **Data Fetching:** `CountriesViewModel` tells `CountriesService` to fetch the JSON data.
    * `CountriesService` uses `URLSession` to perform the network request.
    * On success, it decodes the JSON data into an array of `[Country]` objects using `JSONDecoder`.
    * On failure or completion, it calls the completion handler passed by the ViewModel.
4.  **Data Processing:** The `CountriesViewModel` receives the `[Country]` array (or an empty array on error).
    * It stores the full list in `allCountries` and the list to be displayed in `filteredCountries`.
    * It notifies its delegate (`CountriesViewController`) via the `didUpdateCountries` or `didFailToLoadCountries` delegate methods on the main thread.
5.  **UI Update:** `CountriesViewController` receives the update from the ViewModel.
    * It updates its local `countries` array.
    * It calls `tableView.reloadData()` to refresh the table view.
6.  **Cell Configuration:** The `tableView(_:cellForRowAt:)` data source method dequeues or creates `CountryCell` instances.
    * It configures each cell with the data for the corresponding `Country` object.
    * `CountryCell` uses AutoLayout to arrange the labels according to the requirements.
7.  **Searching:**
    * As the user types in the `UISearchController`'s search bar, the `updateSearchResults(for:)` method (part of `UISearchResultsUpdating`) is called.
    * This method calls `viewModel.filter(by: searchText)`.
    * The `CountriesViewModel` filters its `allCountries` list based on the search text (matching name or capital, case-insensitively) and updates `filteredCountries`.
    * It notifies the `CountriesViewController` via `didUpdateCountries` with the filtered results.
    * The `CountriesViewController` reloads the table view, displaying only the filtered countries.

---

