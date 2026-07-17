//
//  LoadProfileUseCase.swift
//  SOLID-Implementation
//
//  Created by Mohamed Arafa on 16/07/2026.
//

import Foundation

protocol LoadProfileUseCase: Sendable {
    func execute() async throws -> Profile?
}

final class LoadProfile: LoadProfileUseCase {
    
    private let profileAPICliient: ProfileAPIClient
    private let profileCache: CacheUserProfile
    
    init(profileAPICliient: ProfileAPIClient, profileCache: CacheUserProfile) {
        self.profileAPICliient = profileAPICliient
        self.profileCache = profileCache
    }
    
    func execute() async throws -> Profile? {
        do {
            let profile = try await profileAPICliient.fetchProfile()
            try await profileCache.save(profile)
            return profile
        } catch let apiError {
            do {
                if let chachedProfile = try await profileCache.load() {
                    return chachedProfile
                }
            } catch {
                throw error
            }
            throw apiError
        }
    }
}
