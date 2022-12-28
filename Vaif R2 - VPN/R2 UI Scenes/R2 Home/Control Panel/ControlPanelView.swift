//
//  ControlPanelView.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/26/22.
//

import UIKit

class ControlPanelView: UITableView {
    
    // MARK: - @IBOutlets -
    
    @IBOutlet weak var protectionStatusTableCell: UITableViewCell!
    @IBOutlet weak var protectionStatusLabel: UILabel!
    @IBOutlet weak var connectSwitch: UISwitch!
    @IBOutlet weak var entryServerTableCell: UITableViewCell!
    @IBOutlet weak var entryServerConnectionLabel: UILabel!
    @IBOutlet weak var entryServerNameLabel: UILabel!
    @IBOutlet weak var entryServerFlagImage: UIImageView!
    @IBOutlet weak var entryServerIPv6Label: UILabel!
    @IBOutlet weak var fastestServerLabel: UIView!
    @IBOutlet weak var networkView: NetworkViewTableCell!
    @IBOutlet weak var protocolLabel: UILabel!
    @IBOutlet weak var connectionInfoView: ConnectionInfoView!
    
    // MARK: - Properties -
    
    
    
    
    // MARK: - View lifecycle -
    
    override func awakeFromNib() {
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateConnectSwitch()
    }
    
    // MARK: - Methods -
    
    func setupView() {
        connectSwitch.thumbTintColor = .lightGray
        connectSwitch.onTintColor = .blue
        
        updateConnectSwitch()
        UIAccessibility.post(notification: UIAccessibility.Notification.layoutChanged, argument: protectionStatusTableCell)
        
        if UIDevice.screenHeightSmallerThan(device: .iPhones66s78) {
            protectionStatusLabel.font = protectionStatusLabel.font.withSize(28)
        }
    }
    
    func updateVPNStatus(viewModel: VPNStatusViewModel, animated: Bool = true) {
        protectionStatusLabel.text = viewModel.protectionStatusText
        connectSwitch.setOn(viewModel.connectToggleIsOn, animated: animated)
        connectSwitch.accessibilityLabel = viewModel.connectToggleIsOn ? "Switch to disconnect" : "Switch to connect"
        updateConnectSwitch()
        updateServerNames()
    }
    
    func updateServerLabels(viewModel: VPNStatusViewModel) {
        entryServerConnectionLabel.text = viewModel.connectToServerText
    }
    
    func updateServerNames() {
        //        updateServerName(server: Application.shared.settings.selectedServer, label: entryServerNameLabel, flag: entryServerFlagImage, ipv6Label: entryServerIPv6Label)
        //        updateServerName(server: Application.shared.settings.selectedExitServer, label: exitServerNameLabel, flag: exitServerFlagImage, ipv6Label: exitServerIPv6Label)
        //
        //        fastestServerLabel.isHidden = true
    }
    
    
    
    
    // MARK: - Private methods -
    
    //    private func updateServerName(server: VPNServer, label: UILabel, flag: UIImageView, ipv6Label: UILabel) {
    //        let serverViewModel = VPNServerViewModel(server: server)
    //        label.text = serverViewModel.formattedServerNameForMainScreen
    //        flag.image = serverViewModel.imageForCountryCodeForMainScreen
    //        ipv6Label.isHidden = !serverViewModel.showIPv6Label
    //    }
    
    private func updateConnectSwitch() {
        connectSwitch.subviews[0].subviews[0].backgroundColor = .red
        
    }
    
}

