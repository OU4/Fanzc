//
//  RegiesterViewModel.swift
//  Fanzc
//
//  Created by Abdulaziz dot on 24/12/2023.
//

import Foundation

class RegiesterViewModel: ObservableObject {
    @Published  var email = ""
    @Published  var password = ""
    @Published  var fullname = ""
    @Published  var username = ""
    
    
    enum NavigationTarget {
        case registerView2
    }

    
    @Published var selectedOption = "" // For the TextField
        let options = ["Option 1", "Option 2", "Option 3"]
        @Published var showOptions = false // To toggle the display of options
    


    @MainActor
    func createUser() async throws {
      try await  AuthService.shared.createUser(
        withEmail: email,
        password: password,
        fullname: fullname,
        username: username
      )
    }
}
