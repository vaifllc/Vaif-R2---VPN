//
//  ConnectionInfoView.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/26/22.
//

import UIKit

class ConnectionInfoView: UIStackView {
    
    // MARK: - @IBOutlets -
    
    @IBOutlet weak var ipAddressLabel: UILabel!
    @IBOutlet weak var ipAddressLoader: UIActivityIndicatorView!
    @IBOutlet weak var ipAddressErrorLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locationLoader: UIActivityIndicatorView!
    @IBOutlet weak var locationErrorLabel: UILabel!
    @IBOutlet weak var providerLabel: UILabel!
    @IBOutlet weak var providerPlaceholderLabel: UILabel!
    @IBOutlet weak var providerLoader: UIActivityIndicatorView!
    @IBOutlet weak var providerErrorLabel: UILabel!

    
    // MARK: - View lifecycle -
    
    override func awakeFromNib() {
        setup()
    }
    
    // MARK: - Methods -
    
    func setup() {

        ipAddressErrorLabel.icon(text: "Not available", imageName: "icon-wifi-off", alignment: .left)
        locationErrorLabel.icon(text: "Not available", imageName: "icon-wifi-off", alignment: .left)
        providerErrorLabel.icon(text: "Not available", imageName: "icon-wifi-off", alignment: .left)
        
        if UIDevice.screenHeightSmallerThan(device: .iPhones66s78) {
            providerPlaceholderLabel.text = "ISP"
        }
    }
    
    func update(ipv4ViewModel: ProofsViewModel?, ipv6ViewModel: ProofsViewModel?, addressType: AddressType) {
        guard let ipv4ViewModel = ipv4ViewModel, let ipv6ViewModel = ipv6ViewModel else {
            return
        }
        
       // ipProtocolIsHidden = ipv4ViewModel.model == nil || ipv6ViewModel.model == nil
        
        let viewModel = addressType == .IPv6 && ipv4ViewModel.model == nil || ipv6ViewModel.model == nil ? ipv6ViewModel : ipv4ViewModel
        
        ipAddressLabel.text = viewModel.ipAddress
        locationLabel.text = viewModel.location
        providerLabel.text = viewModel.provider
        
        switch viewModel.displayMode {
        case .loading:
            ipAddressLabel.isHidden = true
            ipAddressLoader.startAnimating()
            ipAddressErrorLabel.isHidden = true
            locationLabel.isHidden = true
            locationLoader.startAnimating()
            locationErrorLabel.isHidden = true
            providerLabel.isHidden = true
            providerLoader.startAnimating()
            providerErrorLabel.isHidden = true
        case .content:
            ipAddressLabel.isHidden = false
            ipAddressLoader.stopAnimating()
            ipAddressErrorLabel.isHidden = true
            locationLabel.isHidden = false
            locationLoader.stopAnimating()
            locationErrorLabel.isHidden = true
            providerLabel.isHidden = false
            providerLoader.stopAnimating()
            providerErrorLabel.isHidden = true
        case .error:
            ipAddressLabel.isHidden = true
            ipAddressLoader.stopAnimating()
            ipAddressErrorLabel.isHidden = false
            locationLabel.isHidden = true
            locationLoader.stopAnimating()
            locationErrorLabel.isHidden = false
            providerLabel.isHidden = true
            providerLoader.stopAnimating()
            providerErrorLabel.isHidden = false
        case .none:
            break
        }
        

    }
    
}
