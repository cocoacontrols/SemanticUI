//
//  SwiftUIColorsView.swift
//  Semantic Colors
//
//  Created by Aaron Brethorst on 6/28/23.
//  Copyright © 2023 Cocoa Controls. All rights reserved.
//

import SwiftUI

struct SwiftUIColorsView: View {
    static var hostingController: UIHostingController<SwiftUIColorsView> {
        let hostingController = UIHostingController(rootView: SwiftUIColorsView())
        hostingController.title = "SwiftUI Colors"
        hostingController.tabBarItem.image = UIImage(systemName: "swatchpalette")
        return hostingController
    }

    let colors: [(String, Color)] = [
        (".accentColor", .accentColor),
        (".red", .red),
        (".orange", .orange),
        (".yellow", .yellow),
        (".green", .green),
        (".mint", .mint),
        (".teal", .teal),
        (".cyan", .cyan),
        (".blue", .blue),
        (".indigo", .indigo),
        (".purple", .purple),
        (".pink", .pink),
        (".brown", .brown),
        (".white", .white),
        (".gray", .gray),
        (".black", .black),
        (".clear", .clear),
        (".primary", .primary),
        (".secondary", .secondary)
    ]

    func textColor(for color: Color) -> Color {
        switch color {
        case .white, .clear: return .black
        default: return .white
        }
    }
    
    var body: some View {
        List(colors, id: \.1) { name, c in
            Text(name)
                .foregroundColor(textColor(for: c))
                .listRowBackground(c)
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        SwiftUIColorsView()
    }
}
