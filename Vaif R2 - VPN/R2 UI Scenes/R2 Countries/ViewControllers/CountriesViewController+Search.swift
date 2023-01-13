//
//  CountriesViewController+Search.swift
//  VaifR2
//
//  Created by VAIF on 1/7/23.
//

import Foundation
import Search

extension CountriesViewController: SearchCoordinatorDelegate {
    func userDidSelectCountry(model: Search.CountryViewModel) {
        print("youre smart")
    }
    
    func userDidRequestPlanPurchase() {
        print("youre smart")
    }
    
//    func userDidRequestPlanPurchase() {
//        viewModel.presentAllCountriesUpsell()
//    }
//
//    func userDidSelectCountry(model: CountryViewModel) {
//        guard let cellModel = model as? CountryItemViewModel else {
//            return
//        }
//
//        showCountry(cellModel: cellModel)
//    }

    func reloadSearch() {
        //coordinator?.reload(data: viewModel.searchData, mode: searchMode)
    }

    @objc func showSearch() {
        guard let navigationController = navigationController else {
            return
        }
//
//        coordinator = SearchCoordinator(configuration: Configuration(), storage: viewModel.searchStorage)
//        coordinator?.delegate = self
//        coordinator?.start(navigationController: navigationController, data: viewModel.searchData, mode: searchMode)
    }

    private var searchMode: SearchMode {

        return .standard(.plus)
//        switch viewModel.accountPlan {
//        case .free, .trial, .basic:
//            return .standard(.free)
//        case .plus, .vpnPlus, .family, .bundlePro, .enterprise2022, .visionary, .unlimited, .visionary2022:
//            return .standard(.plus)
//        }
    }
}

