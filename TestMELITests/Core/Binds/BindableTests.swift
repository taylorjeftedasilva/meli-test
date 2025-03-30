//
//  BindableTests.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 30/03/25.
//

import XCTest
@testable import TestMELI

final class BindableTests: XCTestCase {

    func testInitialValue() {
        let bindable = Bindable(value: 10)
        XCTAssertEqual(bindable.value, 10)
    }

    func testBindingHandlerIsCalledImmediately() {
        let expectation = self.expectation(description: "Handler deve ser chamado imediatamente")

        let bindable = Bindable(value: "Hello")
        bindable.bind { newValue in
            XCTAssertEqual(newValue, "Hello")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testBindingHandlerIsCalledOnValueChange() {
        let expectation = self.expectation(description: "Handler deve ser chamado quando o valor muda")

        let bindable = Bindable(value: 0)
        bindable.bind { newValue in
            if newValue == 5 {
                expectation.fulfill()
            }
        }

        bindable.value = 5
        wait(for: [expectation], timeout: 1.0)
    }
}
