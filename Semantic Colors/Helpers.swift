//
//  Helpers.swift
//  Semantic Colors
//
//  Created by Aaron Brethorst on 11/10/19.
//  Copyright © 2019 Cocoa Controls. All rights reserved.
//

import UIKit

// MARK: - UIStackView

extension UIStackView {
    
    /// Creates a stack view configured for displaying content vertically.
    /// - Parameter arrangedSubviews: The views to display within the returned stack view.
    public static func verticalStack(arrangedSubviews: [UIView]) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: arrangedSubviews)
        stack.axis = .vertical
        stack.spacing = UIView.defaultPadding
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
}

// MARK: - UIView

extension UIView {
    
    public static let defaultCornerRadius: CGFloat = 8.0
    
    public static let defaultPadding: CGFloat = 10.0
    
    public static let defaultDirectionalLayoutMargins = NSDirectionalEdgeInsets(top: defaultPadding, leading: defaultPadding, bottom: defaultPadding, trailing: defaultPadding)

    /// Creates a new instance of the receiver class, configured for use with Auto Layout.
    /// - Returns: An instance of the receiver class.
    public static func autolayoutNew() -> Self {
        let view = self.init(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func pinToSuperviewEdges() {
        guard let superview = superview else { return }
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }
    
    func pinToSuperviewLayoutMargins() {
        guard let superview = superview else { return }
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.layoutMarginsGuide.topAnchor),
            leadingAnchor.constraint(equalTo: superview.layoutMarginsGuide.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.layoutMarginsGuide.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.layoutMarginsGuide.bottomAnchor)
        ])
    }
}
