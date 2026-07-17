//
//  EmailValidator.swift
//  SOLID-Implementation
//
//  Created by Mohamed Arafa on 16/07/2026.
//

import Foundation

struct EmailValidator {
    func isValid(email: String) -> Bool {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedEmail.contains("@") && trimmedEmail.contains(".")
    }
}
