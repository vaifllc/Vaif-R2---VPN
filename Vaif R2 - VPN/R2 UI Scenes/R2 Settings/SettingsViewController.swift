//
//  SettingsViewController.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/28/22.
//

import UIKit


final class SettingsViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    var genericDataSource: GenericTableViewDataSource?
    var viewModel: SettingsViewModel? {
        didSet {
            viewModel?.pushHandler = { [pushViewController] viewController in
                pushViewController(viewController)
            }
            viewModel?.reloadNeeded = { [weak self] in
                guard let self = self, self.isViewLoaded else {
                    return
                }

                self.setupTableView()
                self.tableView.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        navigationItem.title = "Settings"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .secondaryBackgroundColor()
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().topItem?.title = LocalizedString.settings
        tabBarItem = UITabBarItem(title: "Settings", image: IconProvider.cogWheel, tag: 4)
        tabBarItem.accessibilityIdentifier = "Settings back btn"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupTableView()
        tableView.reloadData()
        //setupAnnouncements()
    }
    
    private func setupView() {

        navigationItem.title = "Settings"
        view.backgroundColor = ColorProvider.FloatyBackground
        view.layer.backgroundColor = ColorProvider.FloatyBackground.cgColor
    }
    
    private func setupTableView() {
        guard let viewModel = viewModel else { return }
        
        genericDataSource = GenericTableViewDataSource(for: tableView, with: viewModel.tableViewData)
        tableView.dataSource = genericDataSource
        tableView.delegate = genericDataSource
        
        tableView.separatorColor = .normalSeparatorColor()
        tableView.separatorInset = .zero
        tableView.backgroundColor = ColorProvider.FloatyBackground
        tableView.cellLayoutMarginsFollowReadableWidth = true
        
        tableView.tableFooterView = viewModel.viewForFooter()
        tableView.contentInset.bottom = UIConstants.cellHeight
        
    }
    
    private func pushViewController(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}

