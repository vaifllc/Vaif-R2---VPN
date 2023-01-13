//
//  CountryCell.swift
//  VaifR2
//
//  Created by VAIF on 1/11/23.
//

import UIKit
import Macaw
public final class CountryCell: UITableViewCell {

    static let chevronRight = UIImage(named: "ic-chevron-right")
    static let chevronsRight = UIImage(named: "ic-chevrons-right")

    // MARK: Outlets

    @IBOutlet weak var connectButton: UIButton!
    
    //@IBOutlet  weak var flagIcon: SVGView!
    @IBOutlet
    weak var countryName: UILabel!

    @IBOutlet weak var flagIcon: SVGView!
    @IBOutlet private weak var p2pIV: UIImageView!
    @IBOutlet private weak var smartIV: UIImageView!
    @IBOutlet private weak var torIV: UIImageView!

    @IBOutlet private weak var rightChevron: UIImageView!
    @IBOutlet private weak var entrySeparator: UIImageView!
    @IBOutlet private weak var flagsStackView: UIStackView!

    // MARK: Properties

//    var searchText: String? {
//        didSet {
//            guard let viewModel = viewModel as? VPNServerViewModel else {
//                return
//            }
//            highlightMatches(countryName, viewModel.description, searchText)
//        }
//    }

     var viewModel: VPNServerViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
//
//            viewModel.connectionChanged = { [weak self] in self?.stateChanged() }
//            countryName.textColor = viewModel.textColor
            //highlightMatches(countryName, viewModel.description, searchText)

//            torIV.isHidden = !viewModel.torAvailable
//            smartIV.isHidden = !viewModel.isSmartAvailable
//            p2pIV.isHidden = !viewModel.p2pAvailable
//
//            backgroundColor = .clear
//            flagIcon.image = viewModel.flag
//            [flagIcon, countryName, torIV, p2pIV, smartIV].forEach { view in
//                view?.alpha = viewModel.alphaOfMainElements
//            }
//            entrySeparator.isHidden = !viewModel.isSecureCoreCountry
//            flagsStackView.spacing = viewModel.isSecureCoreCountry ? 8 : 16

            stateChanged()
        }
    }

    // MARK: Actions

    @IBAction private func connectTapped(_ sender: Any) {
       // viewModel?.connectAction()
    }

    // MARK: Setup

    override public func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        let alphaOfMainElements: CGFloat = 1
        [flagIcon, countryName].forEach { view in
            view?.alpha = alphaOfMainElements
        }
        entrySeparator.image = CountryCell.chevronsRight
        entrySeparator.tintColor = .darkGray
        //backgroundColor = .clear
        rightChevron.image = CountryCell.chevronRight
//        self.layer.cornerRadius = 8
//        self.clipsToBounds = true
        //iconWeakStyle(rightChevron)
        connectButton.addInteraction(UIPointerInteraction(delegate: self))
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        //connectButton.layer.cornerRadius = mode.cornerRadius
    }

    private func stateChanged() {
        //renderConnectButton()

        rightChevron.isHidden = viewModel?.textInPlaceOfConnectIcon != nil
    }
}

extension CountryCell: UIPointerInteractionDelegate {
    public func pointerInteraction(_ interaction: UIPointerInteraction, styleFor region: UIPointerRegion) -> UIPointerStyle? {
        var pointerStyle: UIPointerStyle? = nil
        if let interactionView = interaction.view {
            let targetedPreview = UITargetedPreview(view: interactionView)
            pointerStyle = UIPointerStyle(effect: UIPointerEffect.lift(targetedPreview))
        }
        return pointerStyle
    }
}

