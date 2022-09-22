//
//  PMCountryPicker.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/21/22.
//

import UIKit

public class PMCountryPicker {

    let countryCodeViewModel: CountryCodeViewModel

    public init(searchBarPlaceholderText: String) {
        countryCodeViewModel = CountryCodeViewModel(searchBarPlaceholderText: searchBarPlaceholderText)
    }

    public func getCountryPickerViewController() -> CountryPickerViewController {
        let countryPickerViewController = instatntiateVC(method: CountryPickerViewController.self, identifier: "CountryPickerViewController")
        countryPickerViewController.viewModel = countryCodeViewModel
        return countryPickerViewController
    }

    public func getInitialCode() -> Int {
        return countryCodeViewModel.getPhoneCodeFromName(NSLocale.current.regionCode)
    }
}

extension PMCountryPicker {
    private func instatntiateVC <T: UIViewController>(method: T.Type, identifier: String) -> T {
        let storyboard = UIStoryboard.init(name: "CountryPicker", bundle: PMUIFoundations.bundle)
        let customViewController = storyboard.instantiateViewController(withIdentifier: identifier) as! T
        return customViewController
    }
}

