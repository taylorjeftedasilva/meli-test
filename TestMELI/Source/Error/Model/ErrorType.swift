//
//  ErrorType.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 29/03/25.
//

import UIKit

enum ErrorType {
    case noInternet
    case generic
    
    var icon: UIImage? {
        switch self {
        case .noInternet:
            return UIImage(systemName: "wifi.exclamationmark")
        case .generic:
            return UIImage(systemName: "exclamationmark.triangle.fill")
        }
    }
}
