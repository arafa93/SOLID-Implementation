//
//  ContentView.swift
//  SOLID-UIKit
//
//  Created by Mohamed Arafa on 16/07/2026.
//

import SwiftUI

struct UIKitContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    UIKitContentView()
}
