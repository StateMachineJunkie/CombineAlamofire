//
//  OSLogExtension.swift
//  
//
//  Created by Michael Crawford on 6/11/21.
//

import Foundation
import os.log

public extension OSLog {
    static var subsystem = Bundle.main.bundleIdentifier!

    // Logs API events.
    static let api = OSLog(subsystem: subsystem, category: "API")

    // Logs APP events.
    static let app = OSLog(subsystem: subsystem, category: "APP")
}
