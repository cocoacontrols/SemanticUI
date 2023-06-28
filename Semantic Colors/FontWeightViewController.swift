//
//  FontsWeightViewController.swift
//  Semantic Colors
//
//  Created by JINSEOK on 2023/06/29.
//  Copyright © 2023 Cocoa Controls. All rights reserved.
//

import UIKit

class FontsWeightViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table Rows

    private lazy var rows: [UITableViewCell] = [
        buildCell(name: "Ultra Light", weight: .ultraLight),
        buildCell(name: "Thin", weight: .thin),
        buildCell(name: "Light", weight: .light),
        buildCell(name: "Regular", weight: .regular),
        buildCell(name: "Medium", weight: .medium),
        buildCell(name: "Semibold", weight: .semibold),
        buildCell(name: "Bold", weight: .bold),
        buildCell(name: "Heavy", weight: .heavy),
        buildCell(name: "Black", weight: .black)
    ]
    
    // MARK: - UIViewController
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        
        title = "Fonts Weight"
        tabBarItem.image = UIImage(systemName: "character.cursor.ibeam")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    // MARK: - Table View
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: view.bounds, style: .insetGrouped)
        table.dataSource = self
        table.delegate = self
        table.allowsSelection = false
        return table
    }()
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return buildHeader()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return rows[indexPath.row]
    }
}

// MARK: - Helpers

extension FontsWeightViewController {
    private func buildHeader() -> UITableViewHeaderFooterView {
        let header = UITableViewHeaderFooterView(reuseIdentifier: nil)
        header.textLabel?.numberOfLines = 0
        
        header.textLabel?.text = """
                                 font weight value range is from -1.0 to 1.0,
                                 where 0.0 corresponds to the regular font weight.
                                 The negative side of the value range indicates that the font is light or thin, the positive side means the font is heavier or bolder.
                                 """
        return header
    }
    
    private func buildCell(name: String, weight: UIFont.Weight) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        
        cell.textLabel?.text = name
        cell.textLabel?.font = UIFont.systemFont(ofSize: 17, weight: weight)
        cell.detailTextLabel?.text = calcFontWeight(font: weight)
        return cell
    }
    
    /// Sets the font weight based on UIFont.preferredFont(forTextStyle: .body) == Point size: 17
    /// For a detailed description of the calculated values, see Discussion on the link
    /// https://developer.apple.com/documentation/uikit/uifontdescriptor/traitkey/1616668-weight
    private func calcFontWeight(font: UIFont.Weight) -> String? {
        let font = UIFont.systemFont(ofSize: 17, weight: font)
        guard let fontDescriptor = font.fontDescriptor.object(forKey: .traits) as? [UIFontDescriptor.TraitKey: Any],
              let weightValue = fontDescriptor[.weight] as? NSNumber
        else {
            print("Failed to retrieve font weight")
            return nil
        }
        let weight = weightValue.floatValue
        return String(stringLiteral: "Font weight: \(weight)")
    }
}
