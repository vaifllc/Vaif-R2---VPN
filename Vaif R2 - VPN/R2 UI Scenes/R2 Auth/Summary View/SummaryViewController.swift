//
//  SummaryViewController.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation
import UIKit


public typealias SummaryStartButtonText = String

public enum SummaryScreenVariant {
    case noSummaryScreen
    case screenVariant(ScreenVariant<SummaryStartButtonText, SummaryScreenCustomData>)
}

public struct SummaryScreenCustomData {
    let image: UIImage
    let startButtonText: String

    public init(image: UIImage, startButtonText: String) {
        self.image = image
        self.startButtonText = startButtonText
    }
}

protocol SummaryViewControllerDelegate: AnyObject {
    func startButtonTap()
}

class SummaryViewController: UIViewController, AccessibleView {

    weak var delegate: SummaryViewControllerDelegate?
    var viewModel: SummaryViewModel!
    
    override var preferredStatusBarStyle: UIStatusBarStyle { darkModeAwarePreferredStatusBarStyle() }

    // MARK: Outlets
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var summaryImage: UIImageView!
    
    @IBOutlet weak var summaryWhole: UIImageView!
    
    @IBOutlet weak var header: UILabel! {
        didSet {
            header.textColor = ColorProvider.TextNorm
            header.text = CoreString._su_summary_title
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.textColor = ColorProvider.TextNorm
        }
    }
    @IBOutlet weak var welcomeLabel: UILabel! {
        didSet {
            welcomeLabel.textColor = ColorProvider.TextNorm
            welcomeLabel.text = CoreString._su_summary_welcome
        }
    }
    @IBOutlet weak var startButton: ProtonButton!

    // MARK: View controller life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorProvider.BackgroundNorm
        setupUI()
        generateAccessibilityIdentifiers()
    }

    // MARK: Actions
    
    @IBAction func onStartButtonTap(_ sender: ProtonButton) {
        delegate?.startButtonTap()
    }
    
    // MARK: Private methods

    func setupUI() {
        if let summaryImage = viewModel.summaryImage {
            imageView.image = summaryImage
        } else {
            imageView.image = viewModel.brandIcon
        }
        summaryImage.image = LoginUIImages.summaryImage
        summaryWhole.image = LoginUIImages.summaryWhole
        descriptionLabel.attributedText = viewModel.descriptionText
        startButton.setTitle(viewModel.startButtonText, for: .normal)
    }

}
