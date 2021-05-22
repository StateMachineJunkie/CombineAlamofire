//
//  JPPost.swift
//  
//
//  Created by Michael A. Crawford on 5/21/21.
//

import Foundation

public struct JPPost: Codable, Equatable, Identifiable {
    public let id: Int
    let userId: Int
    let title: String
    let body: String
}
