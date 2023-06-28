//
//  IconsViewController.swift
//  Semantic Colors
//
//  Created by Aaron Brethorst on 11/8/19.
//  Copyright © 2019 Cocoa Controls. All rights reserved.
//

import UIKit
import SFSymbols

class IconsViewController: UIViewController, UISearchBarDelegate, UISearchResultsUpdating {

    // MARK: - Icons
    
    private let cellIdentifier = "identifier"
    
    private lazy var dataSource = IconDataSource(cellIdentifier: cellIdentifier)
    
    private lazy var searchDataSource = IconSearchDataSource(cellIdentifier: cellIdentifier)
        
    // MARK: - UIViewController

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)

        title = "Icons"
        tabBarItem.image = UIImage(systemName: SFSymbol.eyeglasses.id)
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
        
        configureSearch()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(willShowKeyboard(note:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willHideKeyboard(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Table View
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = dataSource
        table.delegate = dataSource
        table.allowsSelection = false
        return table
    }()
    
    // MARK: - Keyboard
    
    @objc private func willShowKeyboard(note: Notification) {
        guard
            let userInfo = note.userInfo,
            let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else {
            return
        }
        
        var insets = tableView.contentInset
        insets.bottom = frame.cgRectValue.height - view.safeAreaInsets.bottom
        
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
    
    @objc private func willHideKeyboard(note: Notification) {
        var insets = tableView.contentInset
        insets.bottom = .zero
            
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
    
    // MARK: - Search
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private func configureSearch() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.delegate = self
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            searchDataSource.filter(text: text)
            tableView.reloadData()
        }
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        tableView.dataSource = searchDataSource
        tableView.delegate = searchDataSource
        tableView.reloadData()

        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.reloadData()
    }
}

// MARK: - IconDataSource

/// A table view data source object that includes support for alphabetical section titles and a section index.
fileprivate class IconDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    private let cellIdentifier: String

    private let collation: UILocalizedIndexedCollation
    private var sections: [[String]]

    init(cellIdentifier: String) {
        self.cellIdentifier = cellIdentifier
        self.collation = UILocalizedIndexedCollation.current()
        self.sections = Array<[String]>(repeating: [], count: collation.sectionTitles.count)
        
        super.init()

        let icons = SFSymbol.allSymbols.map { $0.id }
        let selector = #selector(getter: description)
        
        let sortedObjects = collation.sortedArray(from: icons, collationStringSelector: selector) as! [String]
        for object in sortedObjects {
            let sectionNumber = collation.section(for: object, collationStringSelector: selector)
            sections[sectionNumber].append(object)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let iconName = sections[indexPath.section][indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.imageView?.image = UIImage(systemName: iconName)
        cell.textLabel?.text = iconName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        collation.sectionTitles[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        collation.sectionIndexTitles
    }

    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        collation.section(forSectionIndexTitle: index)
    }
}

// MARK: - IconSearchDataSource

/// A table view data source that includes support for searching.
fileprivate class IconSearchDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private let cellIdentifier: String
    
    init(cellIdentifier: String) {
        self.cellIdentifier = cellIdentifier
    }

    private lazy var allIcons = SFSymbol.allSymbols.map { $0.id }.sorted()
    
    var filteredIcons = [String]()

    func filter(text: String) {
        let searchText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        filteredIcons = allIcons.filter { $0.localizedCaseInsensitiveContains(searchText) }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredIcons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let iconName = filteredIcons[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.imageView?.image = UIImage(systemName: iconName)
        cell.textLabel?.text = iconName
        
        return cell
    }
}
