//
//  AuthService.swift
//  Fanzc
//
//  Created by Abdulaziz dot on 24/12/2023.
//

import Firebase

class AuthService {
    
    @Published var userSession: FirebaseAuth.User?
    
    static let shared = AuthService()
    
    init(){
        self.userSession = Auth.auth().currentUser
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        
        do {
            
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            print("Dubg : create user \(result.user.uid)")
            
        } catch{
            
            print("Debug: Faild to create a user with error \(error.localizedDescription)")
            
        }
        
    }
    
    @MainActor
    func createUser(withEmail email: String, password: String, fullname: String, username: String) async throws {
        
        
        do {
            
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            print("Dubg : create user \(result.user.uid)")
            
        } catch{
            
            print("Debug: Faild to create a user with error \(error.localizedDescription)")
            
        }
    }
    
    func signOut(){
        try? Auth.auth().signOut() // signs out on backend
        self.userSession = nil // this removes session locally and update routing
    }
}
