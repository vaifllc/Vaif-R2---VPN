//
//  NetworkViewTableCell.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/27/22.
//


import UIKit

class NetworkViewTableCell: UITableViewCell {
    
    // MARK: - @IBOutlets -
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var trustLabel: UILabel!
    
    // MARK: - View lifecycle -
    
    override func awakeFromNib() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateNetwork), name: Notification.Name.UpdateNetwork, object: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.async {
            self.updateNetwork()
        }
    }
    
    // MARK: - Methods -
    
    func resetTrustToDefault() {
        if StorageManager.getDefaultTrust() == NetworkTrust.Trusted.rawValue {
            update(trust: NetworkTrust.Untrusted.rawValue)
        } else {
            update(trust: NetworkTrust.Default.rawValue)
        }
    }
    
    func update(trust: String) {
        Application.shared.network.trust = trust
        let network = Application.shared.network
        
        if let networks = StorageManager.fetchNetworks(name: network.name ?? "", type: network.type ?? "") {
            if let first = networks.first {
                first.trust = trust
                StorageManager.saveContext()
            }
        }
        
        updateNetwork()
    }
    
    // MARK: - Private methods -
    
    @objc private func updateNetwork() {
        render(network: Application.shared.network)
    }
    
    private func render(network: Network) {
        trustLabel.isHidden = false
        trustLabel.text = network.trust?.uppercased()
        accessoryType = .disclosureIndicator
        selectionStyle = .default
        
        switch network.trust {
        case NetworkTrust.Untrusted.rawValue:
            trustLabel.backgroundColor = .red
        case NetworkTrust.Trusted.rawValue:
            trustLabel.backgroundColor = .green
        default:
            trustLabel.backgroundColor = .confirmedBlue
        }
        
        switch network.type {
        case NetworkType.wifi.rawValue:
            nameLabel.icon(text: network.name!, imageName: "WiFi")
        case NetworkType.cellular.rawValue:
            nameLabel.icon(text: network.name!, imageName: "Cellular")
        case NetworkType.none.rawValue:
            if network.name == "Wi-Fi" {
                nameLabel.icon(text: network.name!, imageName: "WiFi")
            } else {
                nameLabel.text = network.name
            }
            accessoryType = .none
            selectionStyle = .none
            trustLabel.isHidden = true
        default:
            break
        }
    }
    
}

