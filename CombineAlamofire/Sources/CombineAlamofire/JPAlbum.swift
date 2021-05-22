//
//  JPAlbum.swift
//  
//
//  Created by Michael A. Crawford on 5/21/21.
//

import Foundation

public struct JPAlbum: Codable, Equatable, Identifiable {
    public let id: Int
    let userId: Int
    let title: String
}
