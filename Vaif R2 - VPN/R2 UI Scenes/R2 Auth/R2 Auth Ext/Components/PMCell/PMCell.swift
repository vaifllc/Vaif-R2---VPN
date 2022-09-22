//
//  PMCell.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/21/22.
//

import UIKit


public final class PMCell: UITableViewCell, AccessibleView {

    public static let reuseIdentifier = "PMCell"
    public static let nib = UINib(nibName: "PMCell", bundle: PMUIFoundations.bundle)

    // MARK: - Outlets

    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var arrowImageView: UIImageView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var subtitleLabel: UILabel!

    // MARK: - Properties

    public var title: String? {
        didSet {
            guard let title = title else {
                titleLabel.attributedText = nil
                return
            }

            let style = NSMutableParagraphStyle()
            let attrString = NSMutableAttributedString(string: title)
            style.minimumLineHeight = 24
            style.maximumLineHeight = 24
            attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: title.count))
            titleLabel.attributedText = attrString
        }
    }

    public var subtitle: String? {
        didSet {
            guard let subtitle = subtitle else {
                subtitleLabel.attributedText = nil
                subtitleLabel.isHidden = true
                return
            }

            let style = NSMutableParagraphStyle()
            let attrString = NSMutableAttributedString(string: subtitle)
            style.minimumLineHeight = 20
            style.maximumLineHeight = 20
            attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: subtitle.count))
            subtitleLabel.attributedText = attrString
            subtitleLabel.isHidden = false
        }
    }

    public var icon: UIImage? {
        didSet {
            iconImageView.image = icon
            iconImageView.tintColor = ColorProvider.IconNorm
        }
    }

    public var showArrow: Bool = true {
        didSet {
            arrowImageView.isHidden = !showArrow
        }
    }

    public var isLoading: Bool = false {
        didSet {
            if isLoading {
                activityIndicator.startAnimating()
                arrowImageView.isHidden = true
            } else {
                activityIndicator.stopAnimating()
                arrowImageView.isHidden = showArrow
            }
        }
    }

    public var isDisabled: Bool = false {
        didSet {
            setStateColors()
        }
    }

    // MARK: - Setup

    override public func awakeFromNib() {
        super.awakeFromNib()

        setStateColors()

        activityIndicator.color = ColorProvider.BrandNorm

        // selection color
        selectionStyle = .gray
        let bgColorView = UIView()
        bgColorView.backgroundColor = ColorProvider.Shade10
        selectedBackgroundView = bgColorView
        
        generateAccessibilityIdentifiers()
    }

    private func setStateColors() {
        let color: UIColor = isDisabled ? ColorProvider.TextDisabled : ColorProvider.TextNorm
        titleLabel.textColor = color
        subtitleLabel.textColor = isDisabled ? ColorProvider.TextDisabled : ColorProvider.TextWeak
        iconImageView.tintColor = color
        arrowImageView.image = IconProvider.arrowRight
        arrowImageView.tintColor = color
    }
}

