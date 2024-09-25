//
//  LoginViewModel.swift
//  Fanzc
//
//  Created by Abdulaziz dot on 24/12/2023.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published  var email = ""
    @Published  var password = ""

    @MainActor
    func login() async throws {
      try await  AuthService.shared.login(withEmail: email, password: password)
    }
}
