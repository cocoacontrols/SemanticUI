//
//  DemosController.swift
//  Semantic Colors
//
//  Created by Aaron Brethorst on 11/10/19.
//  Copyright © 2019 Cocoa Controls. All rights reserved.
//

import UIKit

class DemosController: UITableViewController {
    private let cellIdentifier = "identifier"
    
    var demoControllers = [UIViewController]()
    
    var demoControllerSelected: ((UIViewController) -> Void)?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(style: .insetGrouped)
                
        title = NSLocalizedString("demos_controller.title", value: "Semantic UI Demos", comment: "Demos controller title")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        demoControllers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.imageView?.image = demoControllers[indexPath.row].tabBarItem.image
        cell.textLabel?.text = demoControllers[indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        demoControllerSelected?(demoControllers[indexPath.row])
    }
}
