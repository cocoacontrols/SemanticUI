//
//  FontsViewController.swift
//  Semantic Colors
//
//  Created by Aaron Brethorst on 10/29/19.
//  Copyright © 2019 Cocoa Controls. All rights reserved.
//

import UIKit

class FontsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Table Rows

    /// Font text styles, semantic descriptions of the intended use for
    /// a font returned by `UIFont.preferredFont(forTextStyle:)`
    lazy var rows: [UITableViewCell] = [
        buildCell(name: ".largeTitle", font: UIFont.preferredFont(forTextStyle: .largeTitle)),
        buildCell(name: ".title1", font: UIFont.preferredFont(forTextStyle: .title1)),
        buildCell(name: ".title2", font: UIFont.preferredFont(forTextStyle: .title2)),
        buildCell(name: ".title3", font: UIFont.preferredFont(forTextStyle: .title3)),
        buildCell(name: ".headline", font: UIFont.preferredFont(forTextStyle: .headline)),
        buildCell(name: ".subheadline", font: UIFont.preferredFont(forTextStyle: .subheadline)),
        buildCell(name: ".body", font: UIFont.preferredFont(forTextStyle: .body)),
        buildCell(name: ".callout", font: UIFont.preferredFont(forTextStyle: .callout)),
        buildCell(name: ".footnote", font: UIFont.preferredFont(forTextStyle: .footnote)),
        buildCell(name: ".caption1", font: UIFont.preferredFont(forTextStyle: .caption1)),
        buildCell(name: ".caption2", font: UIFont.preferredFont(forTextStyle: .caption2)),
    ]

    // MARK: - UIViewController

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)

        title = "Fonts"
        tabBarItem.image = UIImage(systemName: "textformat")
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        rows[indexPath.row]
    }
}

fileprivate func buildCell(name: String, font: UIFont) -> UITableViewCell {
    let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)

    cell.textLabel?.font = font
    cell.textLabel?.text = name
    cell.detailTextLabel?.text = "Point Size: \(font.pointSize)"

    return cell
}
