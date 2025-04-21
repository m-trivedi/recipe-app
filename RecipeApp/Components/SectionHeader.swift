//
//  SectionHeader.swift
//  RecipeApp
//
//  Created by Mihir Trivedi on 4/17/25.
//

import SwiftUI

struct SectionHeader: View {
    var text: String
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Text(text)
            .font(.title2)
            .bold()
            .foregroundColor(colorScheme == .dark ? .white : .black)
            .listRowInsets(.init(top: 15, leading: 0, bottom: 10, trailing: 0))
            .textCase(nil)
    }
}

#Preview {
    SectionHeader(text: "Hello, World!")
}
