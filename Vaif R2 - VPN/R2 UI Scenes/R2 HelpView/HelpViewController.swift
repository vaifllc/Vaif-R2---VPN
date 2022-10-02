//
//  HelpViewController.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/28/22.
//

import Foundation
import UIKit


protocol HelpViewControllerDelegate: AnyObject {
    func userDidDismissHelpViewController()
    func userDidRequestHelp(item: HelpItem)
}

final class HelpViewController: UIViewController, AccessibleView {

    // MARK: - Outlets

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var closeButton: UIButton!

    // MARK: - Properties

    weak var delegate: HelpViewControllerDelegate?
    var viewModel: HelpViewModel!
    
    override var preferredStatusBarStyle: UIStatusBarStyle { darkModeAwarePreferredStatusBarStyle() }

    // MARK: - Setup

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupTableView()
        generateAccessibilityIdentifiers()
    }

    private func setupUI() {
        view.backgroundColor = ColorProvider.BackgroundNorm
        tableView.backgroundColor = ColorProvider.BackgroundNorm
        titleLabel.textColor = ColorProvider.TextNorm
        closeButton.setImage(IconProvider.crossSmall, for: .normal)
        closeButton.tintColor = ColorProvider.IconNorm
        titleLabel.text = CoreString._ls_help_screen_title
    }

    private func setupTableView() {
        tableView.register(PMCell.nib, forCellReuseIdentifier: PMCell.reuseIdentifier)
        tableView.register(PMTitleCell.nib, forCellReuseIdentifier: PMTitleCell.reuseIdentifier)

        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.reloadData()
    }

    // MARK: - Actions

    @IBAction private func closePressed(_ sender: Any) {
        delegate?.userDidDismissHelpViewController()
    }
}

// MARK: - Table view delegates

extension HelpViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.helpSections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.helpSections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let helpItem = viewModel.helpSections[indexPath.section][indexPath.row]
        switch helpItem {
        case .staticText(let text):
            let cell = tableView.dequeueReusableCell(withIdentifier: PMTitleCell.reuseIdentifier,
                                                     for: indexPath) as! PMTitleCell
            cell.title = text
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: PMCell.reuseIdentifier,
                                                     for: indexPath) as! PMCell
            cell.configure(item: helpItem)
            return cell
        }
    }
}

extension HelpViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let helpItem = viewModel.helpSections[indexPath.section][indexPath.row]
        delegate?.userDidRequestHelp(item: helpItem)
    }
}
