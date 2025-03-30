//
//  Binding.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 26/03/25.
//

import Foundation

final class Binding<T> {
    var value: T {
        didSet {
            self.bindingHandler?(value)
        }
    }
    
    private var bindingHandler: ((T) -> Void)?
    
    init(value: T) {
        self.value = value
    }
    
    func bind(_ handler: @escaping (T) -> Void) {
        self.bindingHandler = handler
        handler(value)
    }
}
