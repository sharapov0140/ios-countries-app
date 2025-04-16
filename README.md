# Countries Project Documentation

## Overview

This document provides complete, up-to-date documentation for the **Countries iOS project**. It explains the project's purpose, architecture, layout, and how the layout correctly handles varying text lengths, specifically ensuring the country code remains pinned to the right without being overlapped.

This iOS application demonstrates how to:

* **Fetch** a list of countries from a remote JSON endpoint.
* **Display** each country in a table view, showing:
    * A top line with `[Name, Region]` pinned to the left.
    * The `[Code]` pinned to the right on the same line.
    * The `[Capital]` pinned below the name/region.
* **Filter** the list of countries in real-time using a search bar.
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
