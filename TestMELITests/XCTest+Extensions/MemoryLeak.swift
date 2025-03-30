//
//  MemoryLeak.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 29/03/25.
//

import XCTest

extension XCTestCase {
    func checkMemoryLeak(for instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            if let instance = instance {
                XCTFail("Memory leak detected: instance \(instance) was not deallocated", file: file, line: line)
            }
        }
    }
}
