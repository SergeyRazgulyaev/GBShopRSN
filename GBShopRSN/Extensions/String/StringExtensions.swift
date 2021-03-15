//
//  StringExtensions.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 11.03.2021.
//

import Foundation

extension String {
    var isTrimmedEmpty: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
