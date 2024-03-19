//
//  FontsDesignViewController.swift
//  Semantic Colors
//
//  Created by Aswani G on 3/18/24.
//  Copyright © 2024 Cocoa Controls. All rights reserved.
//


import UIKit

class FontsDesignViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
        // MARK: - Table Rows

        /// Font text styles, semantic descriptions of the intended use for
        /// a font returned by `UIFont.preferredFont(forTextStyle:)`
        lazy var rows: [UITableViewCell] = [
            buildCell(name: ".default", design: .default),
            buildCell(name: ".rounded", design: .rounded),
            buildCell(name: ".serif", design: .serif),
            buildCell(name: ".monospaced", design: .monospaced)
        ]
        // MARK: - UIViewController

        override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
            super.init(nibName: nil, bundle: nil)

            title = "Fonts Design"
            tabBarItem.image = UIImage(systemName: "textformat.abc")
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

    fileprivate func buildCell(name: String, design: UIFontDescriptor.SystemDesign) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        
        if let fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body).withDesign(design) {
            let roundedFont = UIFont(descriptor: fontDescriptor, size: 17)
            cell.textLabel?.font = roundedFont
        }
        cell.textLabel?.text = name

        return cell
    }
