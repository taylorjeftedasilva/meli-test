//
//  LocalizedString.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 26/03/25.
//

import Foundation

enum LocalizedString: String {
    case baseURL

    var value: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
