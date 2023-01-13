//
//  ConnectViewModel.swift
//  VaifR2
//
//  Created by VAIF on 1/7/23.
//

import UIKit

public protocol ConnectViewModel {
    var connectButtonColor: UIColor { get }
    var connectIcon: UIImage? { get }
    var textInPlaceOfConnectIcon: String? { get }
    var textColor: UIColor { get }

    func connectAction()
}
