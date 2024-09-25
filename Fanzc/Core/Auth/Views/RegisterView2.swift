import SwiftUI

// Define your custom view modifier
struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.white.opacity(0.1)) // Slight opacity for a background
            .foregroundColor(.white) // Text color
            .cornerRadius(5) // Rounded corners
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.white, lineWidth: 1)) // Border
            .padding(.horizontal, 20) // Horizontal padding
    }
}

extension View {
    func styledTextField() -> some View {
        self.modifier(TextFieldModifier())
    }
}

// Define your view model
//class RegisterViewModel: ObservableObject {
//    @Published var email: String = ""
//    // Add other properties and methods for your registration logic
//}

// Define your registration view
struct RegisterView2: View {
    @StateObject var viewModel = RegiesterViewModel()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)

                VStack {
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                                .padding()
                        }
                        Spacer()
                    }

                    VStack(spacing: 20) {
                        Text("Create your account")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        Text("or sign in if you already have one")
                            .font(.headline)
                            .foregroundColor(.gray)

                        // Email TextField with custom styling
                        TextField("Your Email", text: $viewModel.email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .styledTextField()

                        Text("We'll send you a link to verify your email")
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .padding(.bottom, 20)

                        Button{
                            
                            Task{try await viewModel.createUser() }
                            
                        }label: {
                            Text("Sign Up")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: 352, height: 44)
                                .background(.black)
                                .cornerRadius(8)
                                .padding(.top)
                        }
                        .padding(.horizontal)

                        Divider()
                            .background(Color.white)
                            .padding(.vertical, 20)

                        Button(action: {
                            // Perform Google Sign-In
                        }) {
                            HStack {
                                Image(systemName: "globe") // Replace with the Google logo
                                    .foregroundColor(.black)
                                Text("Continue with Google")
                                    .foregroundColor(.black)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(40)
                        }
                        .padding(.horizontal)

                        Spacer()
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct RegisterView2_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView2()
    }
}
