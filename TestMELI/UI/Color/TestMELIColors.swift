//
//  TestMELIColors.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 25/03/25.
//

import Foundation
import UIKit

final class TestMELIColors: UIColor, @unchecked Sendable {
    
    enum Colors {
        case amarelo
    }
    
    func getColor(_ colorName: Colors) -> UIColor {
        switch colorName {
        case .amarelo:
            return UIColor(hex: "#ffe600", alpha: 1.0)
        }
    }
}
