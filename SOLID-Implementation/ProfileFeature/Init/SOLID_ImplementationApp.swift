//
//  SOLID_ImplementationApp.swift
//  SOLID-Implementation
//
//  Created by Mohamed Arafa on 16/07/2026.
//

import SwiftUI

@main
struct SOLID_ImplementationApp: App {
    var body: some Scene {
        WindowGroup {
            UIKitProfileRootView()
                .ignoresSafeArea()
        }
    }
}

private struct UIKitProfileRootView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ProfileViewController {
        ProfileViewController(
            viewModel: ProfileViewModel(
                loadProfile: DemoLoadProfileUseCase()
            )
        )
    }
    
    func updateUIViewController(_ uiViewController: ProfileViewController, context: Context) { }
}

private struct DemoLoadProfileUseCase: LoadProfileUseCase {
    func execute() async throws -> Profile? {
        Profile(name: "Mohamed Arafa", email: "mohamed@example.com")
    }
}
