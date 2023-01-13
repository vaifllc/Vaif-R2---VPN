//
//  ServersFeaturesInformationVC.swift
//  VaifR2
//
//  Created by VAIF on 1/7/23.
//

import UIKit


class ServersFeaturesInformationVC: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var featuresTableView: UITableView!
    
    let viewModel: ServersFeaturesInformationViewModel
    
    init( _ viewModel: ServersFeaturesInformationViewModel ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondaryBackgroundColor()
        titleLbl.text = LocalizedString.informationTitle
        featuresTableView.register(FeatureTableViewCell.nib, forCellReuseIdentifier: FeatureTableViewCell.identifier)
        featuresTableView.dataSource = self
        featuresTableView.delegate = self
    }
    
    // MARK: - Actions
    
    @IBAction func didTapDismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension ServersFeaturesInformationVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.totalFeatures
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.featuresCount(for: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeatureTableViewCell.identifier, for: indexPath) as! FeatureTableViewCell
        cell.viewModel = viewModel.getFeatureViewModel(indexPath: indexPath)
        return cell
    }
}

extension ServersFeaturesInformationVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.headerHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = ServersHeaderView.loadViewFromNib() as ServersHeaderView
        headerView.setName(name: viewModel.titleFor(section))
        headerView.setColor(color: .secondaryBackgroundColor())
        return headerView
    }
}
