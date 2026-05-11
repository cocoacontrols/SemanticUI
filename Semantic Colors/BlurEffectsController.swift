//
//  BlurViewController.swift
//  Semantic Colors
//
//  Created by Aryan Rajput on 07/05/26.
//  Copyright © 2026 Cocoa Controls. All rights reserved.
//

import UIKit

class BlurEffectsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Sections

    private lazy var tableSections: [TableSection] = [
        TableSection(name: "Original Image", rows: [BlurEffectCell(style: nil, name: "")]),
        TableSection(name: "Material Styles", rows: materialBlurEffects),
        TableSection(name: "Light Material Styles", rows: lightMaterialBlurEffects),
        TableSection(name: "Dark Material Styles", rows: darkMaterialBlurEffects),
        TableSection(name: "Legacy Styles", rows: legacyBlurEffects),
    ]
    
    // MARK: - Material Styles
    
    private lazy var materialBlurEffects: [UITableViewCell] = {
        
        var cells: [UITableViewCell] = []
        
        cells.append(BlurEffectCell(style: .systemUltraThinMaterial, name: ".systemUltraThinMaterial"))
        cells.append(BlurEffectCell(style: .systemThinMaterial, name: ".systemThinMaterial"))
        cells.append(BlurEffectCell(style: .systemMaterial, name: ".systemMaterial"))
        cells.append(BlurEffectCell(style: .systemThickMaterial, name: ".systemThickMaterial"))
        cells.append(BlurEffectCell(style: .systemChromeMaterial, name: ".systemChromeMaterial"))
        
        return cells
        
    }()
    
    
    // MARK: - Light Material Styles
    
    private lazy var lightMaterialBlurEffects: [UITableViewCell] = {
        
        var cells: [UITableViewCell] = []
        
        cells.append(BlurEffectCell(style: .systemUltraThinMaterialLight, name: ".systemUltraThinMaterialLight"))
        cells.append(BlurEffectCell(style: .systemThinMaterialLight, name: ".systemThinMaterialLight"))
        cells.append(BlurEffectCell(style: .systemMaterialLight, name: ".systemMaterialLight"))
        cells.append(BlurEffectCell(style: .systemThickMaterialLight, name: ".systemThickMaterialLight"))
        cells.append(BlurEffectCell(style: .systemChromeMaterialLight, name: ".systemChromeMaterialLight"))
        
        
        return cells
    }()
    
    // MARK: - Dark Material Styles
    
    private lazy var darkMaterialBlurEffects: [UITableViewCell] = {
        
        var cells: [UITableViewCell] = []

        cells.append(BlurEffectCell(style: .systemUltraThinMaterialDark, name: ".systemUltraThinMaterialDark"))
        cells.append(BlurEffectCell(style: .systemThinMaterialDark, name: ".systemThinMaterialDark"))
        cells.append(BlurEffectCell(style: .systemMaterialDark, name: ".systemMaterialDark"))
        cells.append(BlurEffectCell(style: .systemThickMaterialDark, name: ".systemThickMaterialDark"))
        cells.append(BlurEffectCell(style: .systemChromeMaterialDark, name: ".systemChromeMaterialDark"))
        
        
        return cells
    }()
        
    // MARK: - Legacy Styles
    
    private lazy var legacyBlurEffects: [UITableViewCell] = {
        
        var cells: [UITableViewCell] = []
        
        cells.append(BlurEffectCell(style: .extraLight, name: ".extraLight"))
        cells.append(BlurEffectCell(style: .light, name: ".light"))
        cells.append(BlurEffectCell(style: .dark, name: ".dark"))
        cells.append(BlurEffectCell(style: .regular, name: ".regular"))
        cells.append(BlurEffectCell(style: .prominent, name: ".prominent"))
        
        
        return cells
    }()
    
    
    // MARK: - UIViewController

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)

        title = NSLocalizedString("blur_view.title", value: "Blur View", comment: "Blur View controller title")
        tabBarItem.image = UIImage(systemName: "photo.on.rectangle.angled")
        tabBarItem.selectedImage = UIImage(systemName: "photo.on.rectangle.angled.fill")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.pinToSuperviewLayoutMargins()
    }
    

    
    // MARK: - TableView
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.allowsSelection = false
        table.rowHeight = 250
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

// MARK: - TableView Cell

fileprivate class BlurEffectCell: UITableViewCell {
    
    private let cellTitle: String
    private let blurStyle: UIBlurEffect.Style?
    
    private lazy var imgView: UIImageView = {
        var img = UIImageView(image: UIImage(named: "BlurBG"))
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = UIView.defaultCornerRadius
        img.clipsToBounds = true
        return img
    }()
    
    private lazy var blurTitle: UILabel = {
        let label = UILabel.autolayoutNew()
        label.text = self.cellTitle
        return label
    }()
    

    init(style blurStyle: UIBlurEffect.Style?, name: String) {
        
        self.blurStyle = blurStyle
        self.cellTitle = name
        
        super.init(style: .default, reuseIdentifier: nil)
        
        configureUI()
        configureBlurEffect()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI(){
        
        contentView.addSubview(blurTitle)
        contentView.addSubview(imgView)
        
        let paddingX = 20.0
        let paddingY = 10.0
        
        NSLayoutConstraint.activate([
            
            blurTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: paddingY),
            blurTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: paddingX),
            blurTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -paddingX),
            
            imgView.topAnchor.constraint(equalTo: blurTitle.bottomAnchor, constant: paddingY),
            imgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: paddingX),
            imgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -paddingX),
            imgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -paddingY),
            
        ])
    }
    
    private func configureBlurEffect(){
        if let blurStyle {
            let blurEffect = UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
            imgView.addSubview(blurEffect)
            
            blurEffect.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                blurEffect.topAnchor.constraint(equalTo: imgView.topAnchor),
                blurEffect.leadingAnchor.constraint(equalTo: imgView.leadingAnchor),
                blurEffect.trailingAnchor.constraint(equalTo: imgView.trailingAnchor),
                blurEffect.bottomAnchor.constraint(equalTo: imgView.bottomAnchor)
            ])
        }
    }
}
