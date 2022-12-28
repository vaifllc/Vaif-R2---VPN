//
//  R2NavigationController.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/23/22.
//

import UIKit

final class R2NavigationController: UINavigationController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI
    func setupUI() {
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.backgroundColor = .backgroundColor()
        self.navigationController?.view.backgroundColor = .backgroundColor()
        

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        //appearance.titleTextAttributes = textAttributes
        appearance.backgroundColor = .backgroundColor()
        appearance.shadowColor = .clear  //removing navigationbar 1 px bottom border.
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
    }
}

