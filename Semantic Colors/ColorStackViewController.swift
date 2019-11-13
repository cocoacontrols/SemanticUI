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
    
    private lazy var primaryLabel = buildLabel(text: "Title (.label)", textStyle: .headline, textColor: .label)
    private lazy var secondaryLabel = buildLabel(text: "Subtitle (.secondaryLabel)", textStyle: .headline, textColor: .secondaryLabel)
    private lazy var tertiaryLabel = buildLabel(text: "Placeholder (.tertiaryLabel)", textStyle: .headline, textColor: .tertiaryLabel)
    private lazy var placeholderLabel = buildLabel(text: "Placeholder 🤷‍♂️ (.placeholderText)", textStyle: .headline, textColor: .placeholderText)
    private lazy var quaternaryLabel = buildLabel(text: "Disabled (.quaternaryLabel)", textStyle: .headline, textColor: .quaternaryLabel)
    
    private lazy var separator: UIView = {
        let view = UIView.autolayoutNew()
        view.backgroundColor = .separator
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 1.0)
        ])
        return view
    }()

    private lazy var primaryBackgroundLabel = buildLabel(text: ".systemBackground")
    
    private lazy var secondaryContainer: UIView = {
        let view = buildContainer(backgroundColor: .secondarySystemBackground)
        view.addSubview(secondaryStack)
        secondaryStack.pinToSuperviewLayoutMargins()
        return view
    }()
    
    private lazy var secondaryBackgroundLabel = buildLabel(text: ".secondarySystemBackground")
    
    private lazy var tertiaryContainer: UIView = {
        let view = buildContainer(backgroundColor: .tertiarySystemBackground)
        view.addSubview(tertiaryStack)
        tertiaryStack.pinToSuperviewLayoutMargins()
        
        return view
    }()
    
    private lazy var tertiaryBackgroundLabel = buildLabel(text: ".tertiarySystemBackground")
    
    private lazy var primaryStack = UIStackView.verticalStack(arrangedSubviews: [primaryLabel, secondaryLabel, tertiaryLabel, placeholderLabel, quaternaryLabel, separator, primaryBackgroundLabel, secondaryContainer])
    
    private lazy var secondaryStack = UIStackView.verticalStack(arrangedSubviews: [secondaryBackgroundLabel, tertiaryContainer])
    
    private lazy var tertiaryStack = UIStackView.verticalStack(arrangedSubviews: [tertiaryBackgroundLabel, UIView.autolayoutNew()])

    // MARK: - Private UI Helpers
    
    private func buildLabel(text: String, textStyle: UIFont.TextStyle = .footnote, textColor: UIColor = .label) -> UILabel {
        let label = UILabel.autolayoutNew()
        label.font = UIFont.preferredFont(forTextStyle: textStyle)
        label.textColor = textColor
        label.setContentHuggingPriority(.required, for: .vertical)
        label.text = text
        return label
    }
    
    private func buildContainer(backgroundColor: UIColor) -> UIView {
        let container = UIView.autolayoutNew()
        container.backgroundColor = backgroundColor
        container.layer.cornerRadius = UIView.defaultCornerRadius
        container.directionalLayoutMargins = UIView.defaultDirectionalLayoutMargins
        return container
    }
}
