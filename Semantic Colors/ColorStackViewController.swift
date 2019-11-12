//
//  ColorStackViewController.swift
//  Semantic Colors
//
//  Created by Aaron Brethorst on 11/9/19.
//  Copyright © 2019 Cocoa Controls. All rights reserved.
//

import UIKit

class ColorStackViewController: UIViewController {
    // MARK: - UIViewController

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)

        title = NSLocalizedString("color_stack.title", value: "Color Stack", comment: "Color Stack controller title")
        tabBarItem.image = UIImage(systemName: "square.stack.3d.up")
        tabBarItem.selectedImage = UIImage(systemName: "square.stack.3d.up.fill")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        additionalSafeAreaInsets = UIEdgeInsets(top: UIView.defaultPadding, left: 0, bottom: UIView.defaultPadding, right: 0)
        
        view.backgroundColor = .systemBackground

        view.addSubview(primaryStack)
        primaryStack.pinToSuperviewLayoutMargins()
    }
    
    // MARK: - UI Properties
    
    private lazy var titleLabel = buildLabel(text: ".systemBackground")
    
    private lazy var secondaryContainer: UIView = {
        let view = buildContainer(backgroundColor: .secondarySystemBackground)
        view.addSubview(secondaryStack)
        secondaryStack.pinToSuperviewLayoutMargins()
        return view
    }()
    
    private lazy var secondaryLabel = buildLabel(text: ".secondarySystemBackground")
    
    private lazy var tertiaryContainer: UIView = {
        let view = buildContainer(backgroundColor: .tertiarySystemBackground)
        view.addSubview(tertiaryStack)
        tertiaryStack.pinToSuperviewLayoutMargins()
        
        return view
    }()
    
    private lazy var tertiaryLabel = buildLabel(text: ".tertiarySystemBackground")
    
    private lazy var primaryStack = buildStackView(arrangedSubviews: [titleLabel, secondaryContainer])
    
    private lazy var secondaryStack = buildStackView(arrangedSubviews: [secondaryLabel, tertiaryContainer])
    
    private lazy var tertiaryStack = buildStackView(arrangedSubviews: [tertiaryLabel, UIView.autolayoutNew()])

    // MARK: - Private UI Helpers
    
    private func buildLabel(text: String) -> UILabel {
        let label = UILabel.autolayoutNew()
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.text = text
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }
    
    private func buildContainer(backgroundColor: UIColor) -> UIView {
        let container = UIView.autolayoutNew()
        container.backgroundColor = backgroundColor
        container.layer.cornerRadius = UIView.defaultCornerRadius
        container.directionalLayoutMargins = UIView.defaultDirectionalLayoutMargins
        return container
    }
    
    private func buildStackView(arrangedSubviews: [UIView]) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: arrangedSubviews)
        stack.axis = .vertical
        stack.spacing = UIView.defaultPadding
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
}
