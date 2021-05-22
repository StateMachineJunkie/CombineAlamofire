//
//  JPUser.swift
//  
//
//  Created by Michael A. Crawford on 5/21/21.
//

import Foundation

/// See documentation for `AlbumId`.
public struct UserId: Codable, Equatable, Hashable, RawRepresentable {
    public typealias RawValue = Int
    public var rawValue: Int

    public init?(rawValue: Int) {
        self.rawValue = rawValue
    }
}

public struct JPLocation: Codable, Equatable {
    public let lat: String
    public let lng: String
}

public struct JPAddress: Codable, Equatable {
    public let street: String
    public let suite: String
    public let city: String
    public let zipcode: String // TODO: Create custom type
    public let geo: JPLocation
}

public struct JPCompany: Codable, Equatable {
    public let name: String
    public let catchPhrase: String
    public let bs: String
}

public struct JPUser: Codable, Equatable, Identifiable {
    public let id: UserId
    public let name: String
    public let username: String
    public let email: MCEmailAddress
    public let address: JPAddress
    public let phone: String // TODO: Create custom type
    public let website: URL
    public let company: JPCompany
}
