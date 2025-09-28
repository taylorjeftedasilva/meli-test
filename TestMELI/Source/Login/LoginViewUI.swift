//
//  LoginViewUI.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 27/09/25.
//

import SwiftUI

struct CustomInputStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
        .frame(height: 44)
        .padding(.leading, 10)
        .background(Color.white, in: .buttonBorder)
    }
}

struct CustomButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(Color.white)
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(Color.blue, in: .buttonBorder)
            .cornerRadius(8)
    }
}

struct LoginViewUI<T: LoginViewModelProtocol>: View {
    
    @State private var email = ""
    @State private var password = ""
    @FocusState private var emailFieldIsFocused: Bool
    @FocusState private var passwordFieldIsFocused: Bool
    
    private let LOGIN: String = "Login"
    private let SENHA: String = "Senha"
    private let EMAIL: String = "Email"
    private let ENTRAR: String = "Entrar"
    @ObservedObject private var viewModel: T
    private let coordinator: LoginCoordinatorProtocol
    
    public init(viewModel: T = LoginViewModel(), coordinator: LoginCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        self.viewModel.delegate = coordinator
    }
    
    var body: some View {
        VStack(alignment: .center) {
            
            Text(LOGIN)
                .foregroundStyle(Color.black)
                .font(.system(size: 24, weight: .bold))
            
            TextField(text: $email) {
                Text(EMAIL)
            }
            .customInputStyle()
            .keyboardType(.emailAddress)
            .focused($emailFieldIsFocused)
            
            SecureField(text: $password) {
                Text(SENHA)
            }
            .customInputStyle()
            .padding(.top, 20)
            .focused($passwordFieldIsFocused)
            
            Button(action: submitEntryButton) {
                builderButton()
            }
            .padding(.top, 30)
            
            Spacer()
        }
        .padding(EdgeInsets(top: 40,
                             leading: 20,
                             bottom: 0,
                             trailing: 20))
        .background(Color(TestMELIColors().getColor(.amarelo)))
        .onAppear() {
            emailFieldIsFocused = true
            passwordFieldIsFocused = false
        }
    }
    
    @ViewBuilder
    private func builderButton() -> some View {
        if viewModel.loading {
            ProgressView()
                .customButtonStyle()
        } else {
            Text(ENTRAR)
                .customButtonStyle()
        }
    }
    
    private func submitEntryButton() {
        emailFieldIsFocused = false
        passwordFieldIsFocused = false
        viewModel.handleLogin(email: email, password: password)
    }
}

private extension View {
    func customButtonStyle() -> some View {
        self.modifier(CustomButtonStyle())
    }
    
    func customInputStyle() -> some View {
        self.modifier(CustomInputStyle())
    }
}
