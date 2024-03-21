//
//  FontsDesignViewController.swift
//  Semantic Colors
//
//  Created by Aswani G on 3/18/24.
//  Copyright © 2024 Cocoa Controls. All rights reserved.
//


import UIKit

class FontsDesignViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
        var fontSize = 17.0
        // MARK: - Table Rows

        /// set font design by `UIFont.preferredFontDescriptor(withTextStyle:).withDesign
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
            buildHeader()
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
extension FontsDesignViewController {
    
    @objc func increaseFontSize(_ sender: UIButton) {
        guard fontSize < 100 else {
            fontSize = 17.0
            return
        }
        fontSize += 1
        updateFontSizes()
        tableView.reloadData()
    }
    
    @objc func decreaseFontSize(_ sender: UIButton) {
        guard fontSize > 0 else {
            fontSize = 17.0
            return
        }
        fontSize -= 1
        updateFontSizes()
        tableView.reloadData()
    }
    
    private func updateFontSizes() {
        for cell in rows {
            cell.textLabel?.font = cell.textLabel?.font.withSize(fontSize)

            cell.detailTextLabel?.text = "Point Size: \(fontSize)"
        }

        tableView.reloadData()
    }

    
    private func buildHeader() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        headerView.backgroundColor = .systemGray6

        let label = UILabel(frame: CGRect(x: 10, y: 10, width: 100, height: 30))
        label.text = "Font Size"
        headerView.addSubview(label)

        let decreaseButton = UIButton(type: .system)
        decreaseButton.setTitle("-", for: .normal)
        decreaseButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        decreaseButton.frame = CGRect(x: 130, y: 10, width: 30, height: 30)
        decreaseButton.addTarget(self, action: #selector(decreaseFontSize), for: .touchUpInside)
        headerView.addSubview(decreaseButton)

        let increaseButton = UIButton(type: .system)
        increaseButton.setTitle("+", for: .normal)
        increaseButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        increaseButton.frame = CGRect(x: 170, y: 10, width: 30, height: 30)
        increaseButton.addTarget(self, action: #selector(increaseFontSize), for: .touchUpInside)
        headerView.addSubview(increaseButton)

        tableView.tableHeaderView = headerView
    }
    
    fileprivate func buildCell(name: String, design: UIFontDescriptor.SystemDesign) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        
        if let fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body).withDesign(design) {
            let roundedFont = UIFont(descriptor: fontDescriptor, size: fontSize)
            cell.textLabel?.font = roundedFont
            cell.detailTextLabel?.text = "Point Size: \(roundedFont.pointSize)"
        }
        cell.textLabel?.text = name
        
        return cell
    }
}
