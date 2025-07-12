//
//  AnimationCompletions.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 12/07/25.
//

import SwiftUI

struct AnimationCompletionObserverModifier<Value>: AnimatableModifier where Value: VectorArithmetic {
    var targetValue: Value
    var completion: () -> Void

    var animatableData: Value {
        didSet {
            notifyCompletionIfFinished()
        }
    }

    init(observedValue: Value, completion: @escaping () -> Void) {
        self.completion = completion
        self.animatableData = observedValue
        self.targetValue = observedValue
    }

    func body(content: Content) -> some View {
        content
    }

    private func notifyCompletionIfFinished() {
        if animatableData == targetValue {
            DispatchQueue.main.async {
                self.completion()
            }
        }
    }
}
