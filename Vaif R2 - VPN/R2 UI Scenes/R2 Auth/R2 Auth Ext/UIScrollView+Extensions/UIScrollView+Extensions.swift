//
//  UIScrollView+Extensions.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/21/22.
//

import Foundation
import UIKit

extension NotificationCenter {

    func setupKeyboardNotifications(target: Any, show: Selector, hide: Selector) {
        addObserver(target, selector: show, name: UIResponder.keyboardWillShowNotification, object: nil)
        addObserver(target, selector: hide, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension UIViewController {

    func adjust(_ scrollView: UIScrollView, notification: NSNotification, topView: UIView, bottomView: UIView) {
        guard navigationController?.topViewController === self else { return }
        scrollView.adjust(forKeyboardVisibilityNotification: notification)
        scrollView.ensureVisibility(of: topView, downToIfPossible: bottomView)
    }

    func topView(of first: UIView, _ second: UIView, _ views: UIView...) -> UIView {
        ([first] + [second] + views).first { $0.isFirstResponder } ?? first
    }
}

extension UIScrollView {

    func adjust(forKeyboardVisibilityNotification notification: NSNotification?) {

        guard let notification = notification else {
            centerIfNeeded()
            return
        }

        switch notification.name {

        case UIResponder.keyboardWillShowNotification, UIResponder.keyboardDidShowNotification:
            guard let userInfo = notification.userInfo,
                  let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
                contentInset.bottom = 0
                centerIfNeeded()
                return
            }
            let keyboardHeight = superview?.convert(keyboardFrame.cgRectValue, from: nil).size.height ?? 0
            let offsetToMove = keyboardHeight - contentInset.top
            if offsetToMove > 0 {
                if offsetToMove < bounds.size.height - keyboardHeight {
                    contentInset.bottom = offsetToMove
                } else {
                    contentInset.bottom = keyboardHeight
                }
            }
            centerIfNeeded()

        case UIResponder.keyboardWillHideNotification, UIResponder.keyboardDidHideNotification:
            contentInset.bottom = 0
            centerIfNeeded()

        default:
            assertionFailure("\(#function) should never be called with non-keyboard notification")
        }
    }

    private func centerIfNeeded() {
        guard traitCollection.horizontalSizeClass == .regular else { return }
        let offset = (bounds.height - contentInset.bottom - contentSize.height) / 2.0
        let limitedOffset = max(0, offset)
        contentInset.top = limitedOffset
    }

    fileprivate func ensureVisibility(of topView: UIView, downToIfPossible bottomView: UIView) {
        let topRect = convert(topView.frame, from: topView.superview)
        let bottomRect = convert(bottomView.frame, from: bottomView.superview)
        var visibleRect = topRect.union(bottomRect)
        let availableHeight = bounds.height - contentInset.bottom
        visibleRect.origin.y -= 24
        visibleRect.size.height = min(availableHeight, visibleRect.height + 24)
        scrollRectToVisible(visibleRect, animated: false)
    }
}


