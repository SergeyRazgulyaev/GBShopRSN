//
//  LoggerExtension.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 30.03.2021.
//

import Foundation
import os.log

extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!
    static let viewCycle = Logger(subsystem: subsystem, category: "viewCycle")
}
