//
//  SpashViewUI.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 12/07/25.
//

import SwiftUI

struct SpashViewUI: View {

    @State private var opacity: Double = 0
    private let backgroundColor = Color(TestMELIColors().getColor(.amarelo))
    let delegate: SplashViewControllerDelegate
   
    var body: some View {
        VStack() {
            Text("SwiftUI Meli")
                .font(.system(size: 60, weight: .bold))
                .foregroundStyle(.white)
                .opacity(opacity)
                .onAnimationCompleted(for: opacity) {
                    delegate.startLogin()
                }.onAppear {
                    withAnimation(.easeIn(duration: 3.0)) {
                                    opacity = 1.0
                                }
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(backgroundColor)
    }
    
}
