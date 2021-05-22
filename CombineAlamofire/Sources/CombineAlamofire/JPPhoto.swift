//
//  JPPhoto.swift
//  
//
//  Created by Michael A. Crawford on 5/21/21.
//

import Foundation

public struct JPPhoto: Codable, Equatable, Identifiable {
    public let id: Int
    let albumId: Int
    let title: String
    let url: URL
    let thumbnailUrl: URL
}
