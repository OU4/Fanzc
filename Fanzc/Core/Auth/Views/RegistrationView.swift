////
////  RegistrationView.swift
////  Fanzc
////
////  Created by Abdulaziz dot on 30/11/2023.
////
///
///
///
///import SwiftUI

import SwiftUI
import SDWebImageSwiftUI

struct RegistrationView: View {
    // Array holding the names of the image assets for the creators
    let creatorImages = ["profile_universelle", "profile_eva_sita", "profile_and_more"]
    let creatorNames = ["universelle", "eva_sita"]
    let additionalCreatorsCount = "50,000+"
    
    @State var isAnimating: Bool = false
    
    var body: some View {
        NavigationView{
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    
                    // Club title
                    Text("Fanzc")
                        .padding(.top,50)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    // Connect with fans subtitle
                    Text("Connect with fans")
                        .font(.title3)
                        .foregroundColor(.gray)
                    
                    
                    
                    
                    // Animated Logo Placeholder
                    // You would replace this with your actual animated logo
                    
                    AnimatedImage(name: "gofy4.gif", isAnimating:$isAnimating)
                    Image(systemName: "do")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.white)
                        .padding(.top,50)
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    // Creators Profile Images
                    HStack(spacing: -15) { // Negative spacing for overlap
                        ForEach(creatorImages, id: \.self) { imageName in
                            Image("profile") // Replace with actual image names
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        }
                    }
                    
                    // Creators Information
                    HStack {
                        Text("انظم لقامئة من المشاهير وصناع المحتوى في الالم العربي ")
                            .foregroundColor(.white)
                        
                    }
                    .font(.footnote)
                    .padding(.bottom, 10)
                    .padding(.top,10)
                    
                    NavigationLink(destination: RegisterView2()){
                        Text("Continue")
                            .font(.headline)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(40)
                            .padding(.horizontal)
                        
                        
                    }
                   
                    
                    // Legal Text
                    VStack {
                        Text("By continuing you agree to our")
                            .foregroundColor(.gray)
                            .font(.footnote)
                        HStack {
                            Text("Terms of Use")
                                .underline()
                                .foregroundColor(.gray)
                                .font(.footnote)
                                .onTapGesture {
                                    // Handle Terms of Use tap
                                }
                            Text("and")
                                .foregroundColor(.gray)
                                .font(.footnote)
                            Text("Privacy Policy")
                                .underline()
                                .foregroundColor(.gray)
                                .font(.footnote)
                                .onTapGesture {
                                    // Handle Privacy Policy tap
                                }
                        }
                    }
                    
                    
                    Spacer()
                }
            }
        }
    }
}
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
//
//import SwiftUI
//
//struct RegistrationView: View {
//    @StateObject var viewModel = RegiesterViewModel()
//    @Environment(\.dismiss) var dismiss
//
//    var body: some View {
//        VStack {
//            Spacer() // Pushes content to the top if another Spacer is not used at the bottom
//            Image("logo")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 120, height: 120)
//                .padding()
//            
//            VStack {
//                
//                
//                TextField("Your Email", text: $viewModel.email)
//                    .modifier(TextFiledModifire())
//                
//                SecureField("Password", text: $viewModel.password)
//                    .modifier(TextFiledModifire())
//
//                TextField("Yor name", text: $viewModel.fullname)
//                    .modifier(TextFiledModifire())
//
//                TextField("Username", text: $viewModel.username)
//                    .modifier(TextFiledModifire())
//                
//                TextField("Your School", text: $viewModel.selectedOption, onEditingChanged: { isEditing in
//                                    viewModel.showOptions = isEditing // Show options when the TextField is tapped
//                                })
//                                .modifier(TextFiledModifire())
//
//                                // Display the list of options when the TextField is tapped
//                                if viewModel.showOptions {
//                                    VStack(alignment: .leading, spacing: 0) {
//                                        ForEach(viewModel.options, id: \.self) { option in
//                                            Text(option)
//                                                .padding()
//                                                .frame(maxWidth: .infinity, alignment: .leading)
//                                                .background(Color.white)
//                                                .foregroundColor(Color.black)
//                                                .onTapGesture {
//                                                    viewModel.selectedOption = option
//                                                    viewModel.showOptions = false
//                                                }
//                                        }
//                                    }
//                                    .background(Color.white)
//                                    .cornerRadius(5)
//                                    .shadow(radius: 5)
//                                    .padding(.top, 55) // Adjust this value based on the position of your TextField
//                                }
//                            
//                
//
//            }
//            
//            Button{
//                
//                Task{try await viewModel.createUser() }
//                
//            }label: {
//                Text("Sign Up")
//                    .font(.subheadline)
//                    .fontWeight(.semibold)
//                    .foregroundColor(.white)
//                    .frame(width: 352, height: 44)
//                    .background(.black)
//                    .cornerRadius(8)
//                    .padding(.top)
//            }
//            Spacer() // Centers the content vertically
//            Divider()
//            
//            
//            Button{
//                dismiss()
//                
//                
//            } label: {
//                HStack(spacing:3) {
//                    Text("Already Have an account?")
//                    
//                    Text("Log in")
//                        .fontWeight(.semibold )
//
//                }
//                .foregroundColor(.black)
//                .font(.footnote)
//            }.padding(.vertical,16)
//            }
//        }
//    }
//
//
//// Define the preview for the RegistrationView
//struct RegistrationView_Previews: PreviewProvider {
//    static var previews: some View {
//        RegistrationView()
//    }
//}
