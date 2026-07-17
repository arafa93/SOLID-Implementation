//
//  SwiftUIProfileView.swift
//  SOLID-Implementation
//
//  Created by Mohamed Arafa on 16/07/2026.
//

import SwiftUI

struct SwiftUIProfileView: View {
    
    @State private var viewModel: SwiftUIProfileViewModel
    
    init(viewModel: SwiftUIProfileViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 16) {
            switch viewModel.state {
            case .idle:
                EmptyView()
            case .loading:
                ProgressView()
            case .loaded(let profile):
                profileContent(profile)
            case .failed:
                errorContent
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
        .task {
            await viewModel.loadProfileData()
        }
    }
    
    private func profileContent(_ profile: Profile) -> some View {
        VStack(spacing: 8) {
            Text(profile.name)
                .font(.title2)
                .fontWeight(.semibold)
            
            Text(profile.email)
                .font(.body)
                .foregroundStyle(.secondary)
        }
        .multilineTextAlignment(.center)
    }
    
    private var errorContent: some View {
        VStack(spacing: 12) {
            Text(viewModel.errorMessage ?? "Something went wrong.")
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            
            Button("Retry") {
                Task {
                    await viewModel.loadProfileData()
                }
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    SwiftUIProfileView(
        viewModel: SwiftUIProfileViewModel(
            loadProfile: PreviewLoadProfileUseCase()
        )
    )
}

private struct PreviewLoadProfileUseCase: LoadProfileUseCase {
    func execute() async throws -> Profile? {
        Profile(name: "Mohamed Arafa", email: "mohamed@example.com")
    }
}
