//
//  JPPhoto.swift
//  
//
//  Created by Michael A. Crawford on 5/21/21.
//

import Foundation

public struct JPPhoto: Codable, Equatable {
    let albumId: Int
    let id: Int
    let title: String
    let url: URL
    let thumbnailUrl: URL
}
