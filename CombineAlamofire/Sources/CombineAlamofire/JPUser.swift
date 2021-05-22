//
//  JPUser.swift
//  
//
//  Created by Michael A. Crawford on 5/21/21.
//

import Foundation

public struct JPLocation: Codable, Equatable {
    let lat: String
    let lng: String
}

public struct JPAddress: Codable, Equatable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String // TODO: Create custom type
    let geo: JPLocation
}

public struct JPCompany: Codable, Equatable {
    let name: String
    let catchPhrase: String
    let bs: String
}

public struct JPUser: Codable, Equatable {
    let id: Int
    let name: String
    let username: String
    let email: MCEmailAddress
    let address: JPAddress
    let phone: String   // TODO: Create custom type
    let website: URL
    let company: JPCompany
}
