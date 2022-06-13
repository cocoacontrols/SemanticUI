//
//  ColorsViewController.swift
//  Semantic Colors
//
//  Created by Aaron Brethorst on 9/23/19.
//  Copyright © 2019 Cocoa Controls. All rights reserved.
//

import UIKit

class ColorsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Sections

    private lazy var tableSections: [TableSection] = [
        TableSection(name: "Adaptable Colors", rows: adaptableColors),
        TableSection(name: "Adaptable Colors for iOS 15", rows: newAdaptableColorsForIOS15),
        TableSection(name: "Adaptable Grays", rows: adaptableGrays),
        TableSection(name: "Label Colors", rows: labelColors),
        TableSection(name: "Text Colors", rows: textColors),
        TableSection(name: "Link Color", rows: linkColor),
        TableSection(name: "Separators", rows: separators),
        TableSection(name: "Fill Colors", rows: fillColors),
        TableSection(name: "Background Colors", rows: backgroundColors),
        TableSection(name: "Grouped Background Colors", rows: groupedBackgroundColors),
        TableSection(name: "Non-Adaptable Colors", rows: nonadaptableColors)
    ]

    // MARK: - Adaptable Colors

    /// Some colors that are used by system elements and applications.
    /// These return named colors whose values may vary between different contexts and releases.
    /// Do not make assumptions about the color spaces or actual colors used.
    private lazy var adaptableColors: [UITableViewCell] = {
        var cells = [UITableViewCell]()

        cells.append(buildCell(name: ".systemRed", backgroundColor: .systemRed))
        cells.append(buildCell(name: ".systemGreen", backgroundColor: .systemGreen))
        cells.append(buildCell(name: ".systemBlue", backgroundColor: .systemBlue))
        cells.append(buildCell(name: ".systemIndigo", backgroundColor: .systemIndigo))
        cells.append(buildCell(name: ".systemOrange", backgroundColor: .systemOrange))
        cells.append(buildCell(name: ".systemPink", backgroundColor: .systemPink))
        cells.append(buildCell(name: ".systemPurple", backgroundColor: .systemPurple))
        cells.append(buildCell(name: ".systemTeal", backgroundColor: .systemTeal))
        cells.append(buildCell(name: ".systemYellow", backgroundColor: .systemYellow))
        
        
        return cells
    }()
    
    /// New adaptable colors for iOS 15
    private lazy var newAdaptableColorsForIOS15: [UITableViewCell] = {
        var cells = [UITableViewCell]()
        
        if #available(iOS 15, *) {
            cells.append(buildCell(name: ".systemMint", backgroundColor: .systemMint))
            cells.append(buildCell(name: ".systemCyan", backgroundColor: .systemCyan))
            cells.append(buildCell(name: ".systemBrown", backgroundColor: .systemBrown))
        }
        
        return cells
    }()

    // MARK: - Adaptable Grays

    /// Shades of gray. systemGray is the base gray color.
    ///
    /// The numbered variations, systemGray2 through systemGray6, are grays which increasingly
    /// trend away from systemGray and in the direction of systemBackgroundColor.
    ///
    /// In UIUserInterfaceStyleLight: systemGray1 is slightly lighter than systemGray. systemGray2 is lighter than that, and so on.
    /// In UIUserInterfaceStyleDark:  systemGray1 is slightly darker than systemGray. systemGray2 is darker than that, and so on.
    private lazy var adaptableGrays: [UITableViewCell] = {
        var cells = [UITableViewCell]()

        cells.append(buildCell(name: ".systemGray", backgroundColor: .systemGray))
        cells.append(buildCell(name: ".systemGray2", backgroundColor: .systemGray2))
        cells.append(buildCell(name: ".systemGray3", backgroundColor: .systemGray3))
        cells.append(buildCell(name: ".systemGray4", backgroundColor: .systemGray4))
        cells.append(buildCell(name: ".systemGray5", backgroundColor: .systemGray5))
        cells.append(buildCell(name: ".systemGray6", backgroundColor: .systemGray6))

        return cells
    }()

    // MARK: - Label Colors

    /// Foreground colors for static text and related elements.
    private lazy var labelColors: [UITableViewCell] = {
        var cells = [UITableViewCell]()

        cells.append(buildCell(name: ".label", textColor: .label))
        cells.append(buildCell(name: ".secondaryLabel", textColor: .secondaryLabel))
        cells.append(buildCell(name: ".tertiaryLabel", textColor: .tertiaryLabel))
        cells.append(buildCell(name: ".quaternaryLabel", textColor: .quaternaryLabel))

        return cells
    }()

    // MARK: - Link Color

    /// Foreground color for standard system links.
    private lazy var linkColor: [UITableViewCell] = {
        var cells = [UITableViewCell]()

        cells.append(buildCell(name: ".link", textColor: .link))

        return cells
    }()

    // MARK: - Text Colors

    /// Foreground color for placeholder text in controls or text fields or text views.
    private lazy var textColors: [UITableViewCell] = {
        var cells = [UITableViewCell]()

        cells.append(buildCell(name: ".placeholderText", textColor: .placeholderText))

        return cells
    }()

    // MARK: - Separators

    /// Foreground colors for separators (thin border or divider lines).
    /// `separatorColor` may be partially transparent, so it can go on top of any content.
    /// `opaqueSeparatorColor` is intended to look similar, but is guaranteed to be opaque, so it will
    /// completely cover anything behind it. Depending on the situation, you may need one or the other.
    private lazy var separators: [UITableViewCell] = {
        var cells = [UITableViewCell]()

        cells.append(buildCell(name: ".separator", backgroundColor: .separator))
        cells.append(buildCell(name: ".opaqueSeparator", backgroundColor: .opaqueSeparator))

        return cells
    }()

    // MARK: - Fill Colors

    /// Fill colors for UI elements.
    ///
    /// These are meant to be used over the background colors, since their alpha component is less than 1.
    ///
    /// systemFillColor is appropriate for filling thin and small shapes.
    /// Example: The track of a slider.
    ///
    /// secondarySystemFillColor is appropriate for filling medium-size shapes.
    /// Example: The background of a switch.
    ///
    /// tertiarySystemFillColor is appropriate for filling large shapes.
    /// Examples: Input fields, search bars, buttons.
    ///
    /// quaternarySystemFillColor is appropriate for filling large areas containing complex content.
    /// Example: Expanded table cells.
    private lazy var fillColors: [UITableViewCell] = {
        var cells = [UITableViewCell]()

        cells.append(buildCell(name: ".systemFill", backgroundColor: .systemFill))
        cells.append(buildCell(name: ".secondarySystemFill", backgroundColor: .secondarySystemFill))
        cells.append(buildCell(name: ".tertiarySystemFill", backgroundColor: .tertiarySystemFill))
        cells.append(buildCell(name: ".quaternarySystemFill", backgroundColor: .quaternarySystemFill))

        return cells
    }()

    // MARK: - Background Colors

    /// We provide two design systems (also known as "stacks") for structuring an iOS app's backgrounds.
    ///
    /// Each stack has three "levels" of background colors. The first color is intended to be the
    /// main background, farthest back. Secondary and tertiary colors are layered on top
    /// of the main background, when appropriate.
    ///
    /// Inside of a discrete piece of UI, choose a stack, then use colors from that stack.
    /// We do not recommend mixing and matching background colors between stacks.
    /// The foreground colors above are designed to work in both stacks.
    ///
    /// 1. systemBackground
    ///    Use this stack for views with standard table views, and designs which have a white
    ///    primary background in light mode.
    private lazy var backgroundColors: [UITableViewCell] = {
        var cells = [UITableViewCell]()

        cells.append(buildCell(name: ".systemBackground", backgroundColor: .systemBackground))
        cells.append(buildCell(name: ".secondarySystemBackground", backgroundColor: .secondarySystemBackground))
        cells.append(buildCell(name: ".tertiarySystemBackground", backgroundColor: .tertiarySystemBackground))

        return cells
    }()

    // MARK: - Grouped Background Colors

    /// 2. systemGroupedBackground
    /// Use this stack for views with grouped content, such as grouped tables and
    /// platter-based designs. These are like grouped table views, but you may use these
    /// colors in places where a table view wouldn't make sense.
    private lazy var groupedBackgroundColors: [UITableViewCell] = {
        var cells = [UITableViewCell]()

        cells.append(buildCell(name: ".systemGroupedBackground", backgroundColor: .systemGroupedBackground))
        cells.append(buildCell(name: ".secondarySystemGroupedBackground", backgroundColor: .secondarySystemGroupedBackground))
        cells.append(buildCell(name: ".tertiarySystemGroupedBackground", backgroundColor: .tertiarySystemGroupedBackground))

        return cells
    }()

    // MARK: - Non-Adaptable Colors

    /// lightTextColor is always light, and darkTextColor is always dark, regardless of the current UIUserInterfaceStyle.
    /// When possible, we recommend using `labelColor` and its variants, instead.
    private lazy var nonadaptableColors: [UITableViewCell] = {
        var cells = [UITableViewCell]()

        cells.append(buildCell(name: ".lightText", backgroundColor: .black, textColor: .lightText))
        cells.append(buildCell(name: ".darkText", backgroundColor: .white, textColor: .darkText))

        return cells
    }()

    // MARK: - UIViewController

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)

        title = NSLocalizedString("colors_controller.title", value: "Colors", comment: "Colors controller title")
        tabBarItem.image = UIImage(systemName: "eyedropper")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    // MARK: - Table View

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.allowsSelection = false
        return table
    }()

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        tableSections[section].name
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        tableSections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableSections[section].rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableSections[indexPath.section].rows[indexPath.row]
    }
}

// MARK: - Helpers

fileprivate struct TableSection {
    let name: String
    let rows: [UITableViewCell]
}

fileprivate func buildCell(name: String, backgroundColor: UIColor? = nil, textColor: UIColor? = nil) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: nil)

    if let backgroundColor = backgroundColor {
        cell.backgroundColor = backgroundColor
    }

    cell.textLabel?.text = name

    if let textColor = textColor {
        cell.textLabel?.textColor = textColor
    }

    return cell
}
