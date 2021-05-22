//
//  MCEmailAddress.swift
//  
//
//  Created by Michael A. Crawford on 5/21/21.
//

import Foundation

public struct MCEmailAddress: Codable, Equatable, Hashable {
    private let value: String
}

extension MCEmailAddress: CustomStringConvertible {
    public var description: String {
        return value
    }
}

extension MCEmailAddress: RawRepresentable {
    public typealias RawValue = String

    public var rawValue: RawValue {
        return value
    }

    public init?(rawValue: RawValue) {
        guard rawValue.isValidEmailAddress else { return nil }
        value = rawValue
    }
}

extension String {
    public var isValidEmailAddress: Bool {
        return EmailValidator.validate(input: self)
    }
}

/// Based on https://github.com/vapor/vapor/blob/master/Sources/Vapor/Validation/Convenience/Email.swift
private class EmailValidator {
    public static func validate(input value: String) -> Bool {
        guard let localName = value.components(separatedBy: "@").first, isValidLocalName(localName) else {
            return false
        }
        return value.range(of: ".@.+\\..", options: .regularExpression) != nil
    }

    private static func isValidLocalName(_ string: String) -> Bool {
        let valid = string.filter(isValid)
        return valid.count == string.count
    }

    private static func isValid(_ character: Character) -> Bool {
        switch character {
        case "a"..."z", "A"..."Z", "0"..."9":
            return true
        case "!", "#", "$", "%", "&", "'", "*", "+", "-", "/", "=", "?", "^", "_", "`", "{", "|", "}", "~", ".":
            return true
        default:
            return false
        }
    }
}


