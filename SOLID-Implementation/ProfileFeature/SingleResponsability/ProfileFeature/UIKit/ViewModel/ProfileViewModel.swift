//
//  ProfileViewModel.swift
//  SOLID-Implementation
//
//  Created by Mohamed Arafa on 16/07/2026.
//

import Foundation
import SwiftUI

enum ProfileLoadingError: Error {
    case faildToLoad
}

@MainActor
final class ProfileViewModel {
    enum Status: Equatable {
        case idel
        case loading
        case loaded(Profile)
        case faild(ProfileLoadingError)
    }
    
    private let loadProfile: LoadProfileUseCase
    private(set) var state: Status = .idel {
        didSet {
            onStateChange?(state)
        }
    }
    var onStateChange: ((Status) -> Void)?
    
    init(loadProfile: LoadProfileUseCase) {
        self.loadProfile = loadProfile
    }
    
    func onAppear() {
        Task {
            state = .loading
            
            do {
                guard let profile = try await loadProfile.execute() else {
                    state = .faild(.faildToLoad)
                    return
                }
                state = .loaded(profile)
            } catch {
                state = .faild(.faildToLoad)
            }
        }
    }
    
}
