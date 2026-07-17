//
//  CacheUserProfile.swift
//  SOLID-Implementation
//
//  Created by Mohamed Arafa on 16/07/2026.
//

import Foundation

protocol CacheUserProfile {
    func save(_ profile: Profile) async throws
    func load() async throws -> Profile?
}

final class UserProfileCache: CacheUserProfile {
    
    private let userDefault: UserDefaults
    private let key: String = "cached_profile"
    
    init(userDefault: UserDefaults = .standard) {
        self.userDefault = userDefault
    }
    
    func save(_ profile: Profile) async throws {
        let data = try JSONEncoder().encode(
            CodableProfile(profile: profile)
        )
        
        userDefault.set(data, forKey: key)
    }
    
    func load() async throws -> Profile? {
        guard let data = userDefault.data(forKey: key) else {
            return nil
        }
        
        let chachedProfile = try JSONDecoder().decode(
            CodableProfile.self,
            from: data
        )
        
        return chachedProfile.profile
    }
    
    private struct CodableProfile: Codable {
        let name: String
        let email: String
        
        init(profile: Profile) {
            self.name = profile.name
            self.email = profile.email
        }
        
        var profile: Profile {
            Profile(
                name: name,
                email: email
            )
        }
    }
}
