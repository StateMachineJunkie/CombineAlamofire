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

    public static let create = UserId(rawValue: -1)!
}

public struct JPLocation: Codable, Equatable {
    public let lat: String
    public let lng: String

    public init(lat: String, lng: String) {
        self.lat = lat
        self.lng = lng
    }
}

public struct JPAddress: Codable, Equatable {
    public let street: String
    public let suite: String?
    public let city: String
    public let zipcode: String // TODO: Create custom type
    public let geo: JPLocation?

    public init(street: String, suite: String? = nil, city: String, zipcode: String, geo: JPLocation? = nil) {
        self.street     = street
        self.suite      = suite
        self.city       = city
        self.zipcode    = zipcode
        self.geo        = geo
    }
}

public struct JPCompany: Codable, Equatable {
    public let name: String
    public let catchPhrase: String?
    public let bs: String?

    public init(name: String, catchPhrase: String? = nil, bs: String? = nil) {
        self.name           = name
        self.catchPhrase    = catchPhrase
        self.bs             = bs
    }
}

extension JPCompany {
}

public struct JPUser: Codable, Equatable, Identifiable {
    public let id: UserId
    public let name: String?
    public let username: String
    public let email: MCEmailAddress
    public let address: JPAddress?
    public let phone: String? // TODO: Create custom type
    public let website: URL?
    public let company: JPCompany?
}

extension JPUser {
    /// Replacement for default initializer
    ///
    /// Not sure why a compiler synthesized initializer seems to be unavailable.
    /// Created this one to replace/customize it so I can continue with my coding.
    ///
    /// - Parameters:
    ///   - id: Back-end assigns unique identifier for each `JPUser` value. This is a place-holder.
    ///   - name: User's full name.
    ///   - username: User's assigned name within the system.
    ///   - email: Users's email address.
    ///   - address: User's home address.
    ///   - phone: User's phone number.
    ///   - website: User's website.
    ///   - company: User's company. How many users have their own company?
    public init(username: String,
         email: MCEmailAddress,
         name: String? = nil,
         address: JPAddress? = nil,
         phone: String? = nil,
         website: URL? = nil,
         company: JPCompany? = nil) {
        self.id         = UserId.create
        self.name       = name
        self.username   = username
        self.email      = email
        self.address    = address
        self.phone      = phone
        self.website    = website
        self.company    = company
    }
}
