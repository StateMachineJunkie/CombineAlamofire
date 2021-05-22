//
//  JPComment.swift
//  
//
//  Created by Michael A. Crawford on 5/21/21.
//

import Foundation

public struct JPComment: Codable, Equatable {
    let postId: Int
    let id: Int
    let name: String
    let email: MCEmailAddress
    let body: String
}
