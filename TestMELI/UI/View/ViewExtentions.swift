//
//  ViewExtentions.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 12/07/25.
//

import SwiftUICore

extension View {
    func onAnimationCompleted<Value: VectorArithmetic>(for value: Value, completion: @escaping () -> Void) -> some View {
        self.modifier(AnimationCompletionObserverModifier(observedValue: value, completion: completion))
    }
}
