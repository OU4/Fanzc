//
//  LoginView.swift
//  Fanzc
//
//  Created by Abdulaziz dot on 30/11/2023.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @StateObject var viewModel = LoginViewModel()
    var body: some View {
        NavigationStack {
            
            VStack{
                Spacer()
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width:120, height: 120)
                    .padding()
                VStack{
                    
                    TextField("Your Email", text: $viewModel.email)
                        .autocapitalization(.none)
                        .modifier(TextFiledModifire())

                    SecureField("Password", text: $viewModel.password)
                        .modifier(TextFiledModifire())

                    
                }
                NavigationLink {
                    Text(" Forget Password")
                    
                }label: {
                    Text("forget your password?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.vertical)
                        .padding(.trailing,28)
                        .foregroundColor(.black)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
                }
                Button{
                    
                    Task {try await viewModel.login() }
                    
                }label: {
                    Text("Login")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 352, height: 44)
                        .background(.black)
                        .cornerRadius(8)
                }
                
                Spacer()
                Divider()
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing:3) {
                        Text("Don't have an account?")
                        
                        Text("Sign Up")
                            .fontWeight(.semibold )

                    }
                    .foregroundColor(.black)
                    .font(.footnote)
                }
                .padding(.vertical,16)
            }

            }
        }
    }


#Preview {
    LoginView()
}
