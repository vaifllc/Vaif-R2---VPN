//
//  Search+Configuration.swift
//  VaifR2
//
//  Created by VAIF on 1/7/23.
//

import Foundation
import Search
import UIKit

extension Configuration {
    init() {
        self.init(colors: Colors(background: .backgroundColor(),
                                 text: .normalTextColor(),
                                 brand: .brandColor(),
                                 weakText: .weakTextColor(),
                                 separator: .normalSeparatorColor(),
                                 secondaryBackground: .secondaryBackgroundColor(),
                                 iconWeak: .iconWeak()), constants: Constants(numberOfCountries: 49))
    }
}

protocol SearchStorageFactory: AnyObject {
    func makeSearchStorage() -> SearchStorage
}

final class SearchModuleStorage: SearchStorage {
    private let storage: Storage
    private let key = "RECENT_SEARCHES"

    init(storage: Storage) {
        self.storage = storage
    }

    func clear() {
        storage.removeObject(forKey: key)
    }

    func get() -> [String] {
        return storage.getDecodableValue([String].self, forKey: key) ?? []
    }

    func save(data: [String]) {
        storage.setEncodableValue(data, forKey: key)
    }
}

