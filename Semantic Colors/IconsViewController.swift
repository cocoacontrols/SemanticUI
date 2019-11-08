//
//  IconsViewController.swift
//  Semantic Colors
//
//  Created by Aaron Brethorst on 11/8/19.
//  Copyright © 2019 Cocoa Controls. All rights reserved.
//

import UIKit
import SFSymbol

class IconsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Icons
    
    lazy var icons: [String] = SFSymbol.allCases.map { $0.rawValue }.sorted()
    
    // MARK: - UIViewController

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)

        title = "Icons"
        tabBarItem.image = UIImage(systemName: SFSymbol.eyeglasses.rawValue)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)

        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    // MARK: - Table View
    
    private let cellIdentifier = "identifier"

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        return table
    }()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        icons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let iconName = icons[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.imageView?.image = UIImage(systemName: iconName)
        cell.textLabel?.text = iconName
        
        return cell
    }
}
