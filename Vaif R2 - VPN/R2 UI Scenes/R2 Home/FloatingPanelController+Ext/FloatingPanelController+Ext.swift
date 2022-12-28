//
//  FloatingPanelController+Ext.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/27/22.
//

import UIKit
import FloatingPanel

extension FloatingPanelController {
    
    func setup() {
        surfaceView.shadowHidden = true
        surfaceView.contentInsets = .init(top: 20, left: 0, bottom: 0, right: 0)
        surfaceView.backgroundColor = .secondaryBackgroundColor()
        
        let contentViewController = FloatingPanelController.getControlPanelViewController()
        set(contentViewController: contentViewController)
        track(scrollView: contentViewController.tableView)
    }
    
    static func getControlPanelViewController() -> UITableViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        return storyBoard.instantiateViewController(withIdentifier: "controlPanelView") as! ControlPanelViewController
    }
    
}
