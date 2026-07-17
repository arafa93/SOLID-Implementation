//
//  SwiftUIProfileViewModel.swift
//  SOLID-Implementation
//
//  Created by Mohamed Arafa on 16/07/2026.
//

import Foundation
import Observation

enum SwiftUIProfileLoadingError: Error, Equatable {
    case failedToLoad
}

@MainActor
@Observable
final class SwiftUIProfileViewModel {
    enum State: Equatable {
        case idle
        case loading
        case loaded(Profile)
        case failed(SwiftUIProfileLoadingError)
    }
    
    private let loadProfile: LoadProfileUseCase
    private(set) var state: State = .idle
    
    init(loadProfile: LoadProfileUseCase) {
        self.loadProfile = loadProfile
    }
    
    var errorMessage: String? {
        guard case .failed = state else {
            return nil
        }
        return "Failed to load profile."
    }
    
    func onAppear() {
        Task {
            await loadProfileData()
        }
    }
    
    func loadProfileData() async {
        state = .loading
        
        do {
            guard let profile = try await loadProfile.execute() else {
                state = .failed(.failedToLoad)
                return
            }
            state = .loaded(profile)
        } catch {
            state = .failed(.failedToLoad)
        }
    }
}
