//
//  CountryCodeViewModel.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation
import Foundation


public class CountryCodeViewModel {

    private (set) var sectionNames: [String] = []
    private var countryCodes: [CountryCode] = []
    private var sectionCountryCodes: [String: [CountryCode]] = [:]
    private var searchBarPlaceholderText: String = ""

    // MARK: Public interface
    
    public init() {
       // countryCodes = getCountryCodes()
        prepareData()
    }

    init(searchBarPlaceholderText: String) {
        self.searchBarPlaceholderText = searchBarPlaceholderText
      //  countryCodes = getCountryCodes()
        prepareData()
    }

    func getCountryCodes(section: Int) -> [CountryCode] {
        let name = sectionNames[section]
        return sectionCountryCodes[name] ?? []
    }

    func getCountryCode(indexPath: IndexPath) -> CountryCode? {
        guard indexPath.section < sectionNames.count, indexPath.row < getCountryCodes(section: indexPath.section).count else { return nil }
        return getCountryCodes(section: indexPath.section)[indexPath.row]
    }

    func searchText(searchText: String = "") {
        prepareData(searchText: searchText)
    }

    public func getPhoneCodeFromName(_ name: String?) -> Int {
        let defaultCode = getCountryCodeFromName("US")?.phone_code ?? 1
        guard let name = name else { return defaultCode }
        return getCountryCodeFromName(name)?.phone_code ?? defaultCode
    }

    func getSearchBarPlaceholderText() -> String {
        return searchBarPlaceholderText
    }

    // MARK: Private methods

    private func getCountryCodes() -> [CountryCode] {
        let bundleInstance = PMUIFoundations.bundle
        let urlFile = bundleInstance.url(forResource: "phone_country_code", withExtension: "geojson")!
        var countryCodes: [CountryCode] = []
        do {
            let jsonData = try Data(contentsOf: urlFile)
            countryCodes = try JSONDecoder().decode([CountryCode].self, from: jsonData)
        } catch {
            PMLog.debug("geojson parsing error")
        }
        return countryCodes
    }

    private func prepareData(searchText: String = "") {
        sectionCountryCodes.removeAll()
        var searchCountryCodes = countryCodes

        if !searchText.isEmpty {
            searchCountryCodes = countryCodes.filter {
                $0.country_en.range(of: searchText, options: .caseInsensitive) != nil
            }
        }

        searchCountryCodes.sort { $0.country_en < $1.country_en }
        searchCountryCodes.forEach {
            let firstIndex = $0.country_en.index($0.country_en.startIndex, offsetBy: 1)
            let firstString = String($0.country_en[..<firstIndex])
            if var value = sectionCountryCodes[firstString] {
                value += [$0]
                sectionCountryCodes[firstString] = value
            } else {
                sectionCountryCodes.updateValue([$0], forKey: firstString)
            }
        }
        sectionNames = sectionCountryCodes.keys.sorted { $0 < $1 }
    }

    private func getCountryCodeFromName(_ name: String) -> CountryCode? {
        return countryCodes.first { $0.country_code == name }
    }

}
