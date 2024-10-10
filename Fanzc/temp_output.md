# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Core/Swarm/ViewModel/SwarmViewModel.swift

```
//
//  SwarmViewModel.swift
//  Fanzc
//
//  Created by Abdulaziz dot on 05/10/2024.
//

import Foundation
import CoreLocation

class SwarmViewModel: ObservableObject {
    @Published var nearbyPlaces: [Place] = []
    @Published var leaderboard: [LeaderboardEntry] = []

    func fetchNearbyPlaces() {
        // Implement logic to fetch nearby places
    }
    
    func fetchLeaderboard() {
        // Implement logic to fetch leaderboard data
    }
    
    func checkIn(at place: Place) {
        // Implement check-in logic
    }
}
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Core/Swarm/Model/Models.swift

```
//
//  Models.swift
//  Fanzc
//
//  Created by Abdulaziz dot on 05/10/2024.
//

import Foundation
import CoreLocation

struct Place: Identifiable {
    let id = UUID()
    let name: String
    let category: String
    let location: CLLocationCoordinate2D
}

struct LeaderboardEntry: Identifiable {
    let id = UUID()
    let username: String
    let score: Int
}
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Core/Swarm/View/SwarmView.swift

```
//
//  SwarmView.swift
//  Fanzc
//
//  Created by Abdulaziz dot on 05/10/2024.
//

import SwiftUI

struct SwarmView: View {
    @StateObject private var viewModel = SwarmViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Nearby Places")) {
                    ForEach(viewModel.nearbyPlaces) { place in
                        PlaceRow(place: place, viewModel: viewModel)
                    }
                }
                
                Section(header: Text("Leaderboard")) {
                    ForEach(viewModel.leaderboard) { entry in
                        LeaderboardRow(entry: entry)
                    }
                }
            }
            .navigationTitle("Swarm")
            .onAppear {
                viewModel.fetchNearbyPlaces()
                viewModel.fetchLeaderboard()
            }
        }
    }
}

struct PlaceRow: View {
    let place: Place
    @ObservedObject var viewModel: SwarmViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(place.name)
                Text(place.category)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Button("Check In") {
                viewModel.checkIn(at: place)
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

struct LeaderboardRow: View {
    let entry: LeaderboardEntry
    
    var body: some View {
        HStack {
            Text(entry.username)
            Spacer()
            Text("\(entry.score) points")
        }
    }
}
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Core/Auth/ViewModel/LoginViewModel.swift

```
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
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Core/Auth/ViewModel/RegiesterViewModel.swift

```
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
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Core/Auth/Service/AuthService.swift

```
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
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Core/Auth/Views/RegistrationView.swift

```
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
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Core/Auth/Views/RegisterView2.swift

```
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
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Core/Auth/Views/LoginView.swift

```
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
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Core/Activity/View/ActivityView.swift

```
// File: /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Core/Activity/View/ActivityView.swift

import SwiftUI

struct ActivityView: View {
    @State private var activities: [Activity] = []
    
    var body: some View {
        NavigationView {
            List(activities) { activity in
                ActivityRow(activity: activity)
            }
            .navigationTitle("Activity")
            .onAppear {
                loadActivities()
            }
        }
    }
    
    private func loadActivities() {
        // TODO: Implement actual activity loading
        activities = [
            Activity(id: UUID(), username: "John", action: "liked your post", timestamp: Date()),
            Activity(id: UUID(), username: "Sarah", action: "commented on your photo", timestamp: Date().addingTimeInterval(-3600)),
            Activity(id: UUID(), username: "Mike", action: "started following you", timestamp: Date().addingTimeInterval(-7200))
        ]
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}

// Activity Model
struct Activity: Identifiable {
    let id: UUID
    let username: String
    let action: String
    let timestamp: Date
}

// ActivityRow View
struct ActivityRow: View {
    let activity: Activity
    
    var body: some View {
        HStack {
            ProfileImageView() // Assuming you have this view from earlier
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(activity.username).font(.headline) +
                Text(" \(activity.action)").font(.subheadline)
                
                Text(activity.timestamp, style: .relative)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
    }
}
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Core/Explore/View/ExploreView.swift

```
//
//  ExploreView.swift
//  Fanzc
//
//  Created by Abdulaziz dot on 30/11/2023.
//

import SwiftUI

struct ExploreView: View {
    @State private var searchText = ""
    var body: some View {
        NavigationStack {
            ScrollView{
                LazyVStack{
                    ForEach(0 ... 10, id: \.self){
                        user in
                        VStack { 
                            UserCell()
                        }
                        Divider()
                      
                    }
                    .padding(.vertical,4)
                    
                }
            }
            .navigationTitle("Search")
            .searchable(text: $searchText, prompt: "Search")
        }
    }
}

#Preview {
    ExploreView()
}
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Core/Components/UserAvatarView.swift

```
//
//  UserAvatarView.swift
//  Fanzc
//
//  Created by Abdulaziz dot on 26/09/2024.
//
import SwiftUI
import SDWebImageSwiftUI

struct UserAvatarView: View {
    var imageURL: String
    var size: CGFloat = 50

    var body: some View {
        if let url = URL(string: imageURL) {
            WebImage(url: url)
                .resizable()
                .placeholder {
                    Circle().fill(Color.gray)
                }
                .scaledToFill()
                .frame(width: size, height: size)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .shadow(radius: 3)
        } else {
            Circle()
                .fill(Color.gray)
                .frame(width: size, height: size)
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .shadow(radius: 3)
        }
    }
}
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Core/Components/ProfileImageView.swift

```
import SwiftUI

struct ProfileImageView: View {
    var body: some View {
        Image("profile")
            .resizable()
            .scaledToFill()
            .frame(width: 40, height: 40)
            .clipShape(Circle())
    }
}
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Core/Components/UserCell.swift

```
//
//  UserCell.swift
//  Fanzc
//
//  Created by Abdulaziz dot on 30/11/2023.
//

import SwiftUI

struct UserCell: View {
    var body: some View {
        HStack{
           ProfileImageView()
            VStack(alignment: .leading) {
                
            
                Text("Khaled")
                    .font(.footnote)
                    .fontWeight(.semibold)
                
                Text("abdul12")
                    .font(.footnote)
            }
            Spacer()
            Text("Follow")
                .font(.subheadline)
                .fontWeight(.semibold)
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 32)
                .overlay{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray6), lineWidth:1)
                }
        }
        .padding(.horizontal)

    }
}

#Preview {
    UserCell()
}
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Core/Components/PostView.swift

```
import SwiftUI
import SDWebImageSwiftUI

struct PostView: View {
    let post: Post
    let onLike: (Post) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                UserAvatarView(imageURL: post.authorProfilePictureURL, size: 40)
                VStack(alignment: .leading, spacing: 2) {
                    Text(post.authorName)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Text(post.content)
                        .font(.subheadline)
                }
                Spacer()
                Text(post.timestamp, style: .relative)
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            if let mediaURL = post.mediaURL, let url = URL(string: mediaURL) {
                WebImage(url: url)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
            }

            HStack {
                Button(action: { onLike(post) }) {
                    Image(systemName: post.currentUserLiked ? "heart.fill" : "heart")
                        .foregroundColor(post.currentUserLiked ? .red : .gray)
                }
                Text("\(post.likes)")
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
            }
        }
        .padding(.vertical, 8)
        .background(Color.white)
    }
}
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Core/Components/PostCell.swift

```
import SwiftUI

struct PostCell: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                ProfileImageView()
                VStack(alignment: .leading) {
                    Text("User Name")
                        .font(.headline)
                    Text("2h ago")
                        .font(.caption)
                }
            }
            Text("This is a sample post content.")
            HStack {
                Button(action: {}) {
                    Image(systemName: "heart")
                }
                Button(action: {}) {
                    Image(systemName: "bubble.right")
                }
                Spacer()
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
    }
}
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Core/Profile/EditProfile/View/EditProfileView.swift

```
////
////  EditProfileView.swift
////  Fanzc
////
////  Created by Abdulaziz dot on 23/12/2023.
////
//
//import SwiftUI
//
//struct EditProfileView: View {
//    @State private var bio = ""
//    @State private var link = ""
//    @State private var isPrivateProfile = false
//    
//    var body: some View {
//        NavigationStack{
//            ZStack{
//                Color(.systemGroupedBackground)
//                    .edgesIgnoringSafeArea([.bottom, .horizontal])
//                
//                VStack{
//                    
//                    // Name and profile mage
//                    
//                    HStack{
//                        VStack(alignment: .leading){
//                            Text("name")
//                                .fontWeight(.semibold)
//                            
//                            Text("khaled abdulaziz")
//                        }
//                       
//                        
//                        Spacer()
//                        
//                        ProfileImageView()
//                        
//                        
//                    }
//                    Divider()
//                    
//                    // bio filed
//                    
//                    VStack(alignment: .leading){
//                        Text("Bio")
//                            .fontWeight(.semibold)
//                        TextField("Enter you Bio", text:$bio, axis: .vertical)
//                    }
//                    
//                    
//                    Divider()
//                    
//                    VStack(alignment: .leading){
//                        Text("Link")
//                            .fontWeight(.semibold)
//                        TextField("Add Link...", text:$link)
//                    }
//                   
//                    
//                    Divider()
//                    
//                    Toggle("Priavte Profile", isOn: $isPrivateProfile )
//                    
//                    
//                }
//                .padding()
//                .background(.white)
//                .cornerRadius(10)
//                .overlay{
//                    RoundedRectangle(cornerRadius: 10)
//                        .stroke(Color(.systemGray4), lineWidth:1)
//                }
//                .padding()
//                
//                .font(.footnote)
//                .navigationTitle("Edit Profile")
//                .navigationBarTitleDisplayMode(.inline)
//                
//                .toolbar {
//                    
//                    ToolbarItem(placement: .navigationBarLeading){
//                        Button("Cancel") {
//                            
//                        }
//                        
//                        .font(.subheadline)
//                        .foregroundColor(.black)
//                    }
//                    
//                    ToolbarItem(placement: .navigationBarTrailing){
//                        Button("Done") {
//                            
//                        }
//                        
//                        .font(.subheadline)
//                        .fontWidth(.standard)
//                        .foregroundColor(.black)
//                    }
//                    
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    EditProfileView()
//}
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Core/Profile/Model/ProfileFanzcFilter.swift

```
//
//  ProfileFanzcFilter.swift
//  Fanzc
//
//  Created by Abdulaziz dot on 30/11/2023.
//

import Foundation

enum ProfileFanzcFilter: Int, CaseIterable, Identifiable {
    case posts
    case media
    
    var title: String {
        switch self{
        case .posts: return "Posts"
        case .media: return "Media"
        }
    }
    
    var id: Int {return self.rawValue}
}
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Core/Profile/View/EditProfileView.swift

```
//
//  EditProfileView.swift
//  Fanzc
//
//  Created by Abdulaziz dot on 06/10/2024.
//

import SwiftUI

struct EditProfileView: View {
    @Binding var username: String
    @Binding var bio: String
    var onSave: (String, String) -> Void
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Profile Information")) {
                    TextField("Username", text: $username)
                    TextField("Bio", text: $bio)
                }
            }
            .navigationBarTitle("Edit Profile", displayMode: .inline)
            .navigationBarItems(trailing: Button("Save") {
                onSave(username, bio)
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Core/Profile/View/FriendRequestView.swift

```
import SwiftUI

struct FriendRequestView: View {
    @ObservedObject private var friendRequestService = FriendRequestService()
    
    @State private var newFriendID = ""

    var body: some View {
        VStack {
            TextField("Enter Friend ID", text: $newFriendID)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                friendRequestService.sendFriendRequest(from: "currentUserID", to: newFriendID) { error in
                    if let error = error {
                        print("Error sending friend request: \(error)")
                    } else {
                        print("Friend request sent!")
                    }
                }
            }) {
                Text("Send Friend Request")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(5)
            }

            List(friendRequestService.friendRequests) { request in
                HStack {
                    Text("Request from: \(request.senderID)")
                    Spacer()
                    Button(action: {
                        friendRequestService.respondToRequest(requestID: request.id, status: "accepted") { error in
                            if let error = error {
                                print("Error accepting request: \(error)")
                            } else {
                                print("Request accepted!")
                            }
                        }
                    }) {
                        Text("Accept")
                            .foregroundColor(.green)
                    }
                }
            }
        }
        .padding()
        .onAppear {
            friendRequestService.fetchFriendRequests(forUser: "currentUserID")
        }
    }
}

struct FriendRequestView_Previews: PreviewProvider {
    static var previews: some View {
        FriendRequestView()
    }
}
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Core/Feed/ViewModel/FeedViewModel.swift

```
import Foundation

class FeedViewModel: ObservableObject {
    // Add properties and methods for managing feed data
}
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Core/Feed/View/.swift

```
////
////  PostView.swift
////  Fanzc
////
////  Created by Abdulaziz dot on 26/09/2024.
////
//
//import SwiftUI
//import SDWebImageSwiftUI
//
//struct PostView: View {
//    var post: Post
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text(post.content)
//                .font(.subheadline)
//            if let mediaURL = post.mediaURL, !mediaURL.isEmpty {
//                WebImage(url: URL(string: mediaURL))
//                    .resizable()
//                    .scaledToFit()
//            }
//            HStack {
//                Button(action: {
//                    // Handle like action
//                }) {
//                    Image(systemName: "heart")
//                }
//                Text("\(post.likes) likes")
//            }
//        }
//        .padding()
//    }
//}
//
//struct PostView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostView(post: Post(id: "1", authorID: "user1", content: "Hello World", timestamp: Date(), mediaURL: "", likes: 5))
//    }
//}
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Core/Feed/View/FeedView.swift

```
import SwiftUI
import MapKit

struct FeedView: View {
    @ObservedObject var viewModel: SwarmPostViewModel
    @State private var searchText = ""
    @State private var showingProfile = false
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.3352, longitude: -122.0096),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Top bar with search
                HStack {
                    Button(action: { showingProfile = true }) {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 30, height: 30)
                            .overlay(Text("A").foregroundColor(.orange))
                    }
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    .padding(8)
                    .background(Color.white.opacity(0.3))
                    .cornerRadius(8)
                    
                    Image(systemName: "bell")
                        .foregroundColor(.white)
                }
                .padding(.horizontal)
                .padding(.top, 50)
                .padding(.bottom, 10)
                .background(Color.orange)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        // Map view
                        ZStack(alignment: .bottomTrailing) {
                            Map(coordinateRegion: $region)
                                .frame(height: 200)
                            
                            Text("Apple Maps")
                                .font(.caption)
                                .padding(4)
                                .background(Color.white.opacity(0.7))
                                .cornerRadius(4)
                                .padding(8)
                        }
                        
                        // Statistics
                        HStack(spacing: 0) {
                            FeedStatView(title: "Visited", value: "\(viewModel.posts.count)")
                            FeedStatView(title: "Saved", value: "0")
                            FeedStatView(title: "Categories", value: "0/100")
                        }
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 2)
                        
                        // Check-ins header
                        Text("\(viewModel.posts.count) Check-in")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        // Check-ins list
                        ForEach(viewModel.posts) { post in
                            CheckInView(checkIn: CheckIn(from: post))
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                viewModel.fetchPosts()
            }
            .sheet(isPresented: $showingProfile) {
                Text("Profile View") // Replace with your actual ProfileView when implemented
            }
        }
    }
}

struct FeedStatView: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .center) {
            Text(value)
                .font(.headline)
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .background(Color.white)
    }
}

struct CheckInView: View {
    let checkIn: CheckIn
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Circle()
                .fill(Color.orange)
                .frame(width: 50, height: 50)
                .overlay(Image(systemName: "building.2").foregroundColor(.white))
            
            VStack(alignment: .leading, spacing: 5) {
                Text(checkIn.placeName)
                    .font(.headline)
                Text(checkIn.placeDetail)
                    .font(.subheadline)
                Text("Saudi Arabia")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                HStack {
                    Image(systemName: "medal.fill")
                        .foregroundColor(.yellow)
                    Text("105")
                        .foregroundColor(.orange)
                }
                Text(checkIn.checkInTime, style: .time)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                if !checkIn.message.isEmpty {
                    Text(checkIn.message)
                        .padding(.top, 5)
                }
            }
        }
        .padding(.vertical, 10)
    }
}



struct CheckIn: Identifiable {
    let id: String
    let placeName: String
    let placeDetail: String
    let checkInTime: Date
    let message: String
    let points: Int
    let authorName: String
    let imageURL: String?

    init(from post: Post) {
        self.id = post.id ?? UUID().uuidString
        self.placeName = post.locationName ?? "Unknown Location"
        self.placeDetail = post.locationDetails ?? ""
        self.checkInTime = post.timestamp
        self.message = post.content
        self.points = 105 // You might want to calculate this based on some criteria
        self.authorName = post.authorName
        self.imageURL = post.mediaURL
    }
}
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Core/Feed/View/PostsCell.swift

```
//import SwiftUI
//
//struct PostCell: View {
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            HStack {
//                ProfileImageView()
//                VStack(alignment: .leading) {
//                    Text("User Name")
//                        .font(.headline)
//                    Text("2h ago")
//                        .font(.caption)
//                }
//            }
//            Text("This is a sample post content.")
//            HStack {
//                Button(action: {}) {
//                    Image(systemName: "heart")
//                }
//                Button(action: {}) {
//                    Image(systemName: "bubble.right")
//                }
//                Spacer()
//            }
//        }
//        .padding()
//        .background(Color.white)
//        .cornerRadius(12)
//    }
//}
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Core/Root/ViewModel/TimelineViewModel.swift

```
//// File: /Fanzc/Core/Root/ViewModel/TimelineViewModel.swift
//
//import Foundation
//import SwiftUI
//
//class TimelineViewModel: ObservableObject {
//    @Published var posts: [Post] = []
//    
//    func fetchPosts() async {
//        // Simulate network delay
//        try? await Task.sleep(nanoseconds: 1_000_000_000)
//        
//        // TODO: Replace with actual API call
//        let newPosts = [
//            Post(id: UUID(), author: "John Doe", content: "Hello, Path!", timestamp: Date(), imageURL: nil, reactions: []),
//            Post(id: UUID(), author: "Jane Smith", content: "Check out this view!", timestamp: Date().addingTimeInterval(-3600), imageURL: "https://picsum.photos/400/300", reactions: []),
//            Post(id: UUID(), author: "Alice Johnson", content: "Just finished a great book!", timestamp: Date().addingTimeInterval(-7200), imageURL: nil, reactions: [.like, .love])
//        ]
//        
//        DispatchQueue.main.async {
//            self.posts = newPosts
//        }
//    }
//    
//    func addPost(_ post: Post) {
//        posts.insert(post, at: 0)
//    }
//    
//    func toggleReaction(_ post: Post, _ reaction: Reaction) {
//        guard let index = posts.firstIndex(where: { $0.id == post.id }) else { return }
//        
//        if posts[index].reactions.contains(reaction) {
//            posts[index].reactions.removeAll { $0 == reaction }
//        } else {
//            posts[index].reactions.append(reaction)
//        }
//    }
//}
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Core/Root/ViewModel/ContentViewModel.swift

```
// File: ContentViewModel.swift
import Firebase
import Combine

class ContentViewModel: ObservableObject {
    @Published var userSession: User?

    private var cancellables = Set<AnyCancellable>()

    init() {
        setupSubscribers()
    }

    private func setupSubscribers() {
        Auth.auth().addStateDidChangeListener { _, firebaseUser in
            if let firebaseUser = firebaseUser {
                self.userSession = User(firebaseUser: firebaseUser)
            } else {
                self.userSession = nil
            }
        }
    }
}
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Core/Root/ViewModel/SwarmViewModel.swift

```
//
//  SwarmViewModel.swift
//  Fanzc
//
//  Created by Abdulaziz dot on 05/10/2024.
//

import Foundation
import CoreLocation

class SwarmViewModel: ObservableObject {
    @Published var nearbyPlaces: [Place] = []
    @Published var recentCheckIns: [CheckIn] = []
    @Published var leaderboard: [LeaderboardEntry] = []
    
    func fetchNearbyPlaces() {
        // Implement logic to fetch nearby places
        // This would typically involve using CoreLocation and perhaps a places API
    }
    
    func fetchRecentCheckIns() {
        // Implement logic to fetch recent check-ins from your backend
    }
    
    func fetchLeaderboard() {
        // Implement logic to fetch leaderboard data from your backend
    }
    
    func checkIn(at place: Place) {
        // Implement check-in logic
        // This might involve:
        // 1. Verifying the user's location
        // 2. Updating the backend
        // 3. Updating local scores and leaderboard
        // 4. Possibly triggering notifications for achievements
    }
}
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Core/Root/View/MomentsView.swift

```
////
////  MomentsView.swift
////  Fanzc
////
////  Created by Abdulaziz dot on 25/09/2024.
////
//
//
//// File: /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Views/MomentsView.swift
//
//import SwiftUI
//
//struct MomentsView: View {
//    @State private var moments: [Moment] = []
//    
//    var body: some View {
//        NavigationView {
//            ScrollView {
//                LazyVStack(spacing: 20) {
//                    ForEach(moments) { moment in
//                        MomentCard(moment: moment)
//                    }
//                }
//                .padding()
//            }
//            .navigationTitle("Moments")
//            .onAppear {
//                loadMoments()
//            }
//        }
//    }
//    
//    private func loadMoments() {
//        // TODO: Implement moment loading logic
//        // This is just sample data
//        moments = [
//            Moment(id: UUID(), author: "John Doe", content: "Beautiful sunset!", imageURL: "sunset"),
//            Moment(id: UUID(), author: "Jane Smith", content: "Delicious dinner!", imageURL: "dinner"),
//            Moment(id: UUID(), author: "Alice Johnson", content: "Fun at the beach!", imageURL: "beach")
//        ]
//    }
//}
//
//struct Moment: Identifiable {
//    let id: UUID
//    let author: String
//    let content: String
//    let imageURL: String
//}
//
//struct MomentCard: View {
//    let moment: Moment
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            Image(moment.imageURL)
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(height: 200)
//                .clipped()
//                .cornerRadius(10)
//            
//            Text(moment.author)
//                .font(.headline)
//            
//            Text(moment.content)
//                .font(.subheadline)
//                .foregroundColor(.gray)
//        }
//        .background(Color.white)
//        .cornerRadius(10)
//        .shadow(radius: 5)
//    }
//}
//
//struct MomentsView_Previews: PreviewProvider {
//    static var previews: some View {
//        MomentsView()
//    }
//}
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Core/Root/View/ProfileView.swift

```
import SwiftUI
import SDWebImageSwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @State private var showingLocationAlert = false
    @State private var showingEditProfile = false
    @State private var editedUsername = ""
    @State private var editedBio = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header with location enable message
                Text("This map is looking pretty empty. Enable location to start tracking your adventures!")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Button("Enable Location") {
                    showingLocationAlert = true
                }
                .foregroundColor(.blue)
                .alert(isPresented: $showingLocationAlert) {
                    Alert(title: Text("Enable Location"),
                          message: Text("This app needs your location to track your adventures."),
                          primaryButton: .default(Text("Enable")) {
                              // Handle location enabling
                          },
                          secondaryButton: .cancel())
                }
                
                // Profile Header
                VStack {
                    if let profilePictureURL = viewModel.user.profilePictureURL,
                       let url = URL(string: profilePictureURL) {
                        WebImage(url: url)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                    } else {
                        ZStack {
                            Circle()
                                .fill(Color.orange)
                                .frame(width: 80, height: 80)
                            Text(String(viewModel.user.username.prefix(1)))
                                .font(.title)
                                .foregroundColor(.white)
                        }
                    }
                    
                    Text(viewModel.user.username)
                        .font(.title2)
                    Text(viewModel.user.bio)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    HStack {
                        Image(systemName: "mappin.circle.fill")
                        Text("Makkah, 02")
                    }
                    .font(.caption)
                    .foregroundColor(.gray)
                    
                    Button("Edit") {
                        editedUsername = viewModel.user.username
                        editedBio = viewModel.user.bio
                        showingEditProfile = true
                    }
                    .font(.caption)
                    .foregroundColor(.blue)
                    .sheet(isPresented: $showingEditProfile) {
                        EditProfileView(username: $editedUsername, bio: $editedBio) { newUsername, newBio in
                            viewModel.updateProfile(username: newUsername, bio: newBio)
                        }
                    }
                }
                
                // Stats Grid
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    StatView(title: "Check-ins", value: "\(viewModel.totalCheckIns)", color: .orange)
                    StatView(title: "Categories", value: "\(viewModel.categoriesVisited)/100", color: .green)
                    StatView(title: "Saved Places", value: "\(viewModel.savedPlaces)", color: .blue)
                    StatView(title: "Visited Places", value: "\(viewModel.visitedPlaces)", color: .orange)
                    StatView(title: "Streaks", value: "\(viewModel.streaks)", color: .red)
                    StatView(title: "Mayorships", value: "\(viewModel.mayorships)", color: .purple)
                }
                .padding()
                
                // Photos Section
                VStack(alignment: .leading) {
                    Text("Photos \(viewModel.photos.count)")
                        .font(.headline)
                    
                    if viewModel.photos.isEmpty {
                        Text("Nothing to see here...yet")
                            .foregroundColor(.gray)
                        Text("Add a photo to your next check-in! Future you will thank you.")
                            .font(.caption)
                            .foregroundColor(.gray)
                    } else {
                        // Implement photo grid here
                    }
                }
                .padding()
                
                Button("Check in now") {
                    viewModel.checkIn(at: "Current Location")
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
        }
        .navigationBarItems(trailing: Button(action: {
            // Handle settings action
        }) {
            Image(systemName: "gearshape")
        })
    }
}

// Add the StatView struct here
struct StatView: View {
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack {
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(color.opacity(0.1))
        .cornerRadius(10)
    }
}

// Preview provider for ProfileView
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: ProfileViewModel(user: User(id: "1", username: "Sample User", bio: "Sample bio")))
    }
}
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Core/Root/View/fanzcTabView.swift

```
import SwiftUI

struct fanzcTabView: View {
    @StateObject private var swarmPostViewModel = SwarmPostViewModel()

    @StateObject private var profileViewModel: ProfileViewModel
    
    init(user: User) {
        _profileViewModel = StateObject(wrappedValue: ProfileViewModel(user: user))
    }

    var body: some View {
        TabView {
            FeedView(viewModel: swarmPostViewModel)
                .tabItem {
                    Image(systemName: "house")
                    Text("Feed")
                }
            
            ExploreView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Explore")
                }
            
            SwarmView()
                .tabItem {
                    Image(systemName: "mappin.and.ellipse")
                    Text("Swarm")
                }
            
            ProfileView(viewModel: profileViewModel)
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}

struct fanzcTabView_Previews: PreviewProvider {
    static var previews: some View {
        fanzcTabView(user: User(id: "1", username: "Preview User", bio: "This is a preview"))
    }
}
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Core/Root/View/TimelineView.swift

```
////
////  TimelineView.swift
////  Fanzc
////
////  Created by Abdulaziz dot on 25/09/2024.
////
//
//
//// File: /Fanzc/Views/TimelineView.swift
//
//import SwiftUI
//
//struct TimelineView: View {
//    @State private var posts: [Post] = []
//    @State private var isRefreshing = false
//    
//    var body: some View {
//        NavigationView {
//            ScrollView {
//                PullToRefresh(coordinateSpaceName: "pullToRefresh") {
//                    await refreshPosts()
//                }
//                
//                LazyVStack(spacing: 16) {
//                    ForEach(posts) { post in
//                        PostView(post: post)
//                    }
//                }
//                .padding()
//            }
//            .coordinateSpace(name: "pullToRefresh")
//            .navigationTitle("Timeline")
//            .navigationBarTitleDisplayMode(.inline)
//        }
//        .onAppear {
//            loadPosts()
//        }
//    }
//    
//    private func loadPosts() {
//        // TODO: Implement post loading from your backend
//        // This is a placeholder
//        posts = [
//            Post(id: UUID(), author: "John Doe", content: "Hello, Path!", timestamp: Date()),
//            Post(id: UUID(), author: "Jane Smith", content: "Loving this app!", timestamp: Date())
//        ]
//    }
//    
//    private func refreshPosts() async {
//        isRefreshing = true
//        // TODO: Implement actual refresh logic
//        await Task.sleep(1_000_000_000) // Simulate network delay
//        loadPosts()
//        isRefreshing = false
//    }
//}
//
//struct TimelineView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimelineView()
//    }
//}
//
//// Placeholder Post model
//struct Post: Identifiable {
//    let id: UUID
//    let author: String
//    let content: String
//    let timestamp: Date
//}
//
//// Custom PullToRefresh View
//struct PullToRefresh: View {
//    var coordinateSpaceName: String
//    var onRefresh: () async -> Void
//    
//    @State private var needRefresh: Bool = false
//    
//    var body: some View {
//        GeometryReader { geo in
//            if (geo.frame(in: .named(coordinateSpaceName)).midY > 50) {
//                Spacer()
//                    .onAppear {
//                        needRefresh = true
//                    }
//            } else if (geo.frame(in: .named(coordinateSpaceName)).maxY < 10) {
//                Spacer()
//                    .onAppear {
//                        if needRefresh {
//                            needRefresh = false
//                            Task {
//                                await onRefresh()
//                            }
//                        }
//                    }
//            }
//            HStack {
//                Spacer()
//                if needRefresh {
//                    ProgressView()
//                } else {
//                    Text("⬇️")
//                }
//                Spacer()
//            }
//        }.padding(.top, -50)
//    }
//}
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Core/Root/View/FriendsView.swift

```
////
////  FriendsView.swift
////  Fanzc
////
////  Created by Abdulaziz dot on 25/09/2024.
////
//
//
//// File: /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Views/FriendsView.swift
//
//import SwiftUI
//
//struct FriendsView: View {
//    @State private var friends: [Friend] = []
//    
//    var body: some View {
//        NavigationView {
//            List(friends) { friend in
//                FriendRow(friend: friend)
//            }
//            .navigationTitle("Friends")
//            .onAppear {
//                loadFriends()
//            }
//        }
//    }
//    
//    private func loadFriends() {
//        // TODO: Implement friend loading logic
//        // This is just sample data
//        friends = [
//            Friend(id: UUID(), name: "John Doe", username: "@johndoe"),
//            Friend(id: UUID(), name: "Jane Smith", username: "@janesmith"),
//            Friend(id: UUID(), name: "Alice Johnson", username: "@alicej")
//        ]
//    }
//}
//
//struct Friend: Identifiable {
//    let id: UUID
//    let name: String
//    let username: String
//}
//
//struct FriendRow: View {
//    let friend: Friend
//    
//    var body: some View {
//        HStack {
//            ProfileImageView()
//                .frame(width: 50, height: 50)
//            VStack(alignment: .leading) {
//                Text(friend.name)
//                    .font(.headline)
//                Text(friend.username)
//                    .font(.subheadline)
//                    .foregroundColor(.gray)
//            }
//        }
//    }
//}
//
//struct FriendsView_Previews: PreviewProvider {
//    static var previews: some View {
//        FriendsView()
//    }
//}
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Core/Root/View/ContentView.swift

```
//
//  ContentView.swift
//  Fanzc
//
//  Created by Abdulaziz dot on 30/11/2023.
//
import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()

    var body: some View {
        Group {
            if let user = viewModel.userSession {
                fanzcTabView(user: user) // Pass the user parameter here
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Core/Root/View/ProfileViewModel.swift

```
import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift

class ProfileViewModel: ObservableObject {
    @Published var user: User
    @Published var totalCheckIns: Int = 0
    @Published var categoriesVisited: Int = 0
    @Published var savedPlaces: Int = 0
    @Published var visitedPlaces: Int = 0
    @Published var streaks: Int = 0
    @Published var mayorships: Int = 0
    @Published var photos: [String] = []
    
    private let db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
    
    init(user: User) {
        self.user = user
        setupRealtimeListener()
    }
    
    deinit {
        listenerRegistration?.remove()
    }
    
    private func setupRealtimeListener() {
        guard let currentUser = Auth.auth().currentUser else {
            print("No authenticated user")
            return
        }
        
        listenerRegistration = db.collection("users").document(currentUser.uid)
            .addSnapshotListener { [weak self] documentSnapshot, error in
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                guard let data = document.data() else {
                    print("Document data was empty.")
                    return
                }
                DispatchQueue.main.async {
                    self?.updateUserData(with: data)
                }
            }
    }
    
    private func updateUserData(with data: [String: Any]) {
        self.user.username = data["username"] as? String ?? "Unknown"
        self.user.bio = data["bio"] as? String ?? ""
        self.user.profilePictureURL = data["profilePictureURL"] as? String
        self.totalCheckIns = data["totalCheckIns"] as? Int ?? 0
        self.categoriesVisited = data["categoriesVisited"] as? Int ?? 0
        self.savedPlaces = data["savedPlaces"] as? Int ?? 0
        self.visitedPlaces = data["visitedPlaces"] as? Int ?? 0
        self.streaks = data["streaks"] as? Int ?? 0
        self.mayorships = data["mayorships"] as? Int ?? 0
        self.photos = data["photos"] as? [String] ?? []
    }
    
    func updateProfile(username: String, bio: String) {
        guard let currentUser = Auth.auth().currentUser else {
            print("No authenticated user")
            return
        }
        
        db.collection("users").document(currentUser.uid).updateData([
            "username": username,
            "bio": bio
        ]) { error in
            if let error = error {
                print("Error updating profile: \(error.localizedDescription)")
            } else {
                print("Profile updated successfully")
            }
        }
    }
    
    func checkIn(at place: String) {
        guard let currentUser = Auth.auth().currentUser else {
            print("No authenticated user")
            return
        }
        
        db.collection("users").document(currentUser.uid).updateData([
            "totalCheckIns": FieldValue.increment(Int64(1)),
            "visitedPlaces": FieldValue.increment(Int64(1))
        ]) { error in
            if let error = error {
                print("Error updating check-in: \(error.localizedDescription)")
            } else {
                print("Check-in updated successfully")
            }
        }
    }
}
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Core/Upload/View/UploadView.swift

```
//
//  UploadView.swift
//  Fanzc
//
//  Created by Abdulaziz dot on 30/11/2023.
//

import SwiftUI

struct UploadView: View {
    var body: some View {
        Text("Hello, Upload!")
    }
}

#Preview {
    UploadView()
}
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/GifImage.swift

```
//
//  GifImage.swift
//  Fanzc
//
//  Created by Abdulaziz dot on 26/12/2023.
//

import Foundation
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/FanzcApp.swift

```
//  FanzcApp.swift
//  Fanzc
//
//  Created by Abdulaziz dot on 30/11/2023.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct FanzcApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/TabBar/MainTabView.swift

```
////
////  MainTabView.swift
////  Fanzc
////
////  Created by Abdulaziz dot on 25/09/2024.
////
//
//
//import SwiftUI
//
//struct MainTabView: View {
//    @State private var selectedTab = 0
//    @State private var showPostCreation = false
//    
//    var body: some View {
//        ZStack(alignment: .bottom) {
//            TabView(selection: $selectedTab) {
//                TimelineView()
//                    .tabItem {
//                        Image(systemName: "house.fill")
//                        Text("Home")
//                    }
//                    .tag(0)
//                
//                ExploreView()
//                    .tabItem {
//                        Image(systemName: "magnifyingglass")
//                        Text("Explore")
//                    }
//                    .tag(1)
//                
//                Text("") // Placeholder for center button
//                    .tabItem { Text("") }
//                    .tag(2)
//                
//                ActivityView()
//                    .tabItem {
//                        Image(systemName: "bell.fill")
//                        Text("Activity")
//                    }
//                    .tag(3)
//                
//                ProfileView()
//                    .tabItem {
//                        Image(systemName: "person.fill")
//                        Text("Profile")
//                    }
//                    .tag(4)
//            }
//            .accentColor(PathTheme.primaryColor)
//            
//            // Floating Action Button
//            Button(action: {
//                showPostCreation = true
//            }) {
//                Image(systemName: "plus")
//                    .foregroundColor(.white)
//                    .font(.title2)
//                    .frame(width: 56, height: 56)
//                    .background(PathTheme.primaryColor)
//                    .clipShape(Circle())
//                    .shadow(radius: 4)
//            }
//            .offset(y: -30)
//        }
//        .sheet(isPresented: $showPostCreation) {
//            PostCreationView()
//        }
//    }
//}
//
//struct MainTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainTabView()
//    }
//}
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/TabBar/SwarmView.swift

```
//
//  SwarmView.swift
//  Fanzc
//
//  Created by Abdulaziz dot on 05/10/2024.
//

import SwiftUI

struct SwarmView: View {
    @StateObject private var viewModel = SwarmViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Nearby Places")) {
                    ForEach(viewModel.nearbyPlaces) { place in
                        PlaceRow(place: place, viewModel: viewModel)
                    }
                }
                
                Section(header: Text("Recent Check-ins")) {
                    ForEach(viewModel.recentCheckIns) { checkIn in
                        CheckInRow(checkIn: checkIn)
                    }
                }
                
                Section(header: Text("Leaderboard")) {
                    ForEach(viewModel.leaderboard) { entry in
                        LeaderboardRow(entry: entry)
                    }
                }
            }
            .navigationTitle("Swarm")
            .onAppear {
                viewModel.fetchNearbyPlaces()
                viewModel.fetchRecentCheckIns()
                viewModel.fetchLeaderboard()
            }
        }
    }
}

struct PlaceRow: View {
    let place: Place
    @ObservedObject var viewModel: SwarmViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(place.name)
                Text(place.category)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Button("Check In") {
                viewModel.checkIn(at: place)
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

struct CheckInRow: View {
    let checkIn: CheckIn
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(checkIn.placeName)
            Text(checkIn.date, style: .date)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

struct LeaderboardRow: View {
    let entry: LeaderboardEntry
    
    var body: some View {
        HStack {
            Text(entry.username)
            Spacer()
            Text("\(entry.score) points")
        }
    }
}
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/code_to_pdf.sh

```
#!/bin/bash

# Enable verbose mode
set -x

# Function to print usage
print_usage() {
    echo "Usage: $0 <output_pdf> <directory1> [<directory2> ...]"
    echo "Example: $0 all_code.pdf /path/to/project1 /path/to/project2"
}

# Check if at least two arguments are provided
if [ $# -lt 2 ]; then
    print_usage
    exit 1
fi

# Check if pandoc is installed
if ! command -v pandoc &> /dev/null; then
    echo "Error: pandoc is not installed. Please install pandoc and try again."
    echo "You can install it using your package manager, e.g.:"
    echo "  brew install pandoc"
    exit 1
fi

# Output PDF file name
OUTPUT="$1"
shift

# Temporary markdown file
TEMP_MD="temp_output.md"

# Array of file extensions to include
EXTENSIONS=("swift" "c" "cpp" "h" "hpp" "py" "java" "js" "html" "css" "php" "rb" "go" "rs" "kt" "scala" "pl" "sh" "sql" "ts")

# Clear the temporary markdown file if it exists
> "$TEMP_MD"

# Process each directory
for dir in "$@"; do
    if [ ! -d "$dir" ]; then
        echo "Warning: $dir is not a valid directory. Skipping."
        continue
    fi

    echo "Processing directory: $dir"
    
    # Find and process files
    find "$dir" \( -type d \( -name node_modules -o -name vendor -o -name public \) -prune \) -o \( -type f \( -name "*.swift" -o -name "*.c" -o -name "*.cpp" -o -name "*.h" -o -name "*.hpp" -o -name "*.py" -o -name "*.java" -o -name "*.js" -o -name "*.html" -o -name "*.css" -o -name "*.php" -o -name "*.rb" -o -name "*.go" -o -name "*.rs" -o -name "*.kt" -o -name "*.scala" -o -name "*.pl" -o -name "*.sh" -o -name "*.sql" -o -name "*.ts" \) -print0 \) | while IFS= read -r -d '' file; do
        echo "Processing file: $file"
        echo -e "# $file\n" >> "$TEMP_MD"
        echo '```' >> "$TEMP_MD"
        cat "$file" >> "$TEMP_MD"
        echo '```' >> "$TEMP_MD"
        echo -e "\n\n" >> "$TEMP_MD"
    done
done

# Check if any files were processed
if [ ! -s "$TEMP_MD" ]; then
    echo "Error: No files were found or processed. The output PDF will not be created."
    rm "$TEMP_MD"
    exit 1
fi

# Convert markdown to PDF using pandoc
if pandoc "$TEMP_MD" -o "$OUTPUT" --pdf-engine=xelatex -V geometry:margin=1in; then
    echo "Successfully created PDF: $OUTPUT"
else
    echo "Error: Failed to create PDF"
    echo "Content of temporary markdown file:"
    cat "$TEMP_MD"
    exit 1
fi

# Remove temporary markdown file
rm "$TEMP_MD"

echo "Conversion complete. Output saved as $OUTPUT"

# Disable verbose mode
set +x```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Units/ViewModifares/TextFiledModifire.swift

```
//
//  TextFiledModifire.swift
//  Fanzc
//
//  Created by Abdulaziz dot on 30/11/2023.
//

import SwiftUI

struct TextFiledModifire: ViewModifier {
    
    func body(content: Content) -> some View {
        content
                  .padding(8)
                  .background(Color.white.opacity(0.2))
                  .cornerRadius(20)
                  .padding(.horizontal)
          }
      }

      extension View {
          func customTextField() -> some View {
              self.modifier(TextFiledModifire())
          }
      }
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/PostCreation/Location.swift

```
//
//  Location.swift
//  Fanzc
//
//  Created by Abdulaziz dot on 06/10/2024.
//

import Foundation

struct Location: Identifiable, Codable {
    let id: String
    let name: String
    let details: String
    let distance: String
    
    init(id: String = UUID().uuidString, name: String, details: String, distance: String) {
        self.id = id
        self.name = name
        self.details = details
        self.distance = distance
    }
}
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/PostCreation/SwarmPostViewModel.swift

```
import Foundation
import Firebase
import FirebaseStorage

class SwarmPostViewModel: ObservableObject {
    @Published var posts: [Post] = []
    private var postService = PostService()

    func createPost(content: String, location: Location, image: UIImage?) {
        guard let user = Auth.auth().currentUser else {
            print("No user logged in")
            return
        }

        var mediaURL: String?
        
        let group = DispatchGroup()
        
        if let image = image {
            group.enter()
            uploadImage(image) { result in
                switch result {
                case .success(let url):
                    mediaURL = url
                case .failure(let error):
                    print("Error uploading image: \(error.localizedDescription)")
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            let newPost = Post(
                authorID: user.uid,
                authorName: user.displayName ?? "Unknown User",
                authorProfilePictureURL: user.photoURL?.absoluteString ?? "",
                content: content,
                timestamp: Date(),
                mediaURL: mediaURL,
                likes: 0,
                comments: [],
                currentUserLiked: false,
                locationName: location.name,
                locationDetails: location.details
            )
            
            self.postService.addPost(newPost) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let post):
                        self?.posts.insert(post, at: 0)
                        print("Post added successfully with ID: \(post.id ?? "unknown")")
                    case .failure(let error):
                        print("Error adding post: \(error.localizedDescription)")
                    }
                }
            }
        }
    }

    private func uploadImage(_ image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to convert image to data"])))
            return
        }
        
        let storageRef = Storage.storage().reference().child("post_images/\(UUID().uuidString).jpg")
        
        storageRef.putData(imageData, metadata: nil) { (metadata, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            storageRef.downloadURL { (url, error) in
                if let error = error {
                    completion(.failure(error))
                } else if let url = url {
                    completion(.success(url.absoluteString))
                }
            }
        }
    }

    func fetchPosts() {
        postService.fetchPosts { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedPosts):
                    self?.posts = fetchedPosts
                case .failure(let error):
                    print("Error fetching posts: \(error.localizedDescription)")
                }
            }
        }
    }
}
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/PostCreation/View/SwarmPostCreationView.swift

```
import SwiftUI

struct SwarmPostCreationView: View {
    @ObservedObject var viewModel: SwarmPostViewModel
    @State private var content = ""
    @State private var selectedLocation: Location?
    @State private var isShowingLocationPicker = false
    @State private var isShowingImagePicker = false
    @State private var selectedImage: UIImage?
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Location selection
                Button(action: {
                    isShowingLocationPicker = true
                }) {
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                        Text(selectedLocation?.name ?? "Choose a location")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding()
                    .background(Color.orange.opacity(0.1))
                    .foregroundColor(.orange)
                }
                
                // Content input area
                VStack(alignment: .leading, spacing: 10) {
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .clipped()
                            .cornerRadius(10)
                            .padding(.bottom, 10)
                    }
                    
                    TextEditor(text: $content)
                        .frame(height: 100)
                        .padding(5)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(8)
                    
                    HStack {
                        Button(action: {
                            isShowingImagePicker = true
                        }) {
                            Image(systemName: "photo")
                                .foregroundColor(.blue)
                        }
                        
                        Button(action: {
                            // Add functionality for adding a view
                        }) {
                            Image(systemName: "eye")
                                .foregroundColor(.blue)
                        }
                        
                        Spacer()
                        
                        Text("\(content.count)/280")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 5)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                .padding()
                
                Spacer()
            }
            .navigationBarTitle("Create Post", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancel") { dismiss() },
                trailing: Button("Post") {
                    if let location = selectedLocation {
                        viewModel.createPost(content: content, location: location, image: selectedImage)
                        dismiss()
                    }
                }
                .disabled(content.isEmpty || selectedLocation == nil)
            )
        }
        .sheet(isPresented: $isShowingLocationPicker) {
            LocationPickerView(selectedLocation: $selectedLocation)
        }
        .sheet(isPresented: $isShowingImagePicker) {
            ImagePicker(image: $selectedImage)
        }
    }
}
struct LocationPickerView: View {
    @Binding var selectedLocation: Location?
    @Environment(\.dismiss) var dismiss
    
    let locations = [
        Location(name: "Dhahban", details: "City", distance: "2"),
        Location(name: "Obhur Alshmalyyah", details: "3.5 km", distance: "7"),
        Location(name: "مكان عجيب", details: "1.2 km", distance: ""),
        Location(name: "BAE Systems", details: "300 m", distance: ""),
        Location(name: "Oia Beach", details: "Obhur Rd", distance: "4.9 km 3")
    ]

    var body: some View {
        NavigationView {
            List(locations) { location in
                Button(action: {
                    selectedLocation = location
                    dismiss()
                }) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(location.name)
                                .font(.headline)
                            Text(location.details)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        if !location.distance.isEmpty {
                            Text(location.distance)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationTitle("Choose Location")
            .navigationBarItems(leading: Button("Cancel") { dismiss() })
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct SwarmPostCreationView_Previews: PreviewProvider {
    static var previews: some View {
        SwarmPostCreationView(viewModel: SwarmPostViewModel())
    }
}
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Model/User.swift

```
import Foundation
import FirebaseAuth
import Firebase

struct User: Codable {
    let id: String
    var username: String  // Changed to var
    var bio: String       // Changed to var
    var profilePictureURL: String?
    
    // User initializer
    init(id: String, username: String, bio: String, profilePictureURL: String? = nil) {
        self.id = id
        self.username = username
        self.bio = bio
        self.profilePictureURL = profilePictureURL
    }

    // Initializer for creating a User from FirebaseAuth.User
    init(firebaseUser: FirebaseAuth.User) {
        self.id = firebaseUser.uid
        self.username = firebaseUser.displayName ?? "Unknown"
        self.bio = "" // or fetch from another source or Firestore
        self.profilePictureURL = firebaseUser.photoURL?.absoluteString
    }
    
    // This method should be moved outside the struct as it's not a property or method of User
    static func fetchFirestoreUserProfile(for userID: String, completion: @escaping (User?) -> Void) {
        Firestore.firestore().collection("users").document(userID).getDocument { document, error in
            if let document = document, document.exists, let data = document.data() {
                let id = data["id"] as? String ?? userID
                let username = data["username"] as? String ?? "Unknown"
                let bio = data["bio"] as? String ?? ""
                let profilePictureURL = data["profilePictureURL"] as? String
                
                let user = User(id: id, username: username, bio: bio, profilePictureURL: profilePictureURL)
                completion(user)
            } else {
                print("Error fetching user data: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
            }
        }
    }

    enum CodingKeys: String, CodingKey {
        case id
        case username
        case bio
        case profilePictureURL
    }
}
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Model/FriendRequest.swift

```
//
//  FriendRequest.swift
//  Fanzc
//
//  Created by Abdulaziz dot on 26/09/2024.
//

import Foundation

struct FriendRequest: Codable, Identifiable {
    var id: String
    var senderID: String
    var receiverID: String
    var status: String // "pending", "accepted", "declined"
}
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Model/Post.swift

```
import Foundation
import FirebaseFirestoreSwift


struct Post: Codable, Identifiable {
    @DocumentID var id: String?
    let authorID: String
    let authorName: String
    let authorProfilePictureURL: String
    let content: String
    let timestamp: Date
    let mediaURL: String?
    var likes: Int
    var comments: [Comment]
    var currentUserLiked: Bool
    let locationName: String?
    let locationDetails: String?

    enum CodingKeys: String, CodingKey {
        case id
        case authorID
        case authorName
        case authorProfilePictureURL
        case content
        case timestamp
        case mediaURL
        case likes
        case comments
        case currentUserLiked
        case locationName
        case locationDetails
    }
}

struct Comment: Codable, Identifiable {
    let id: String
    let authorID: String
    let authorName: String
    let content: String
    let timestamp: Date
    let locationName: String
    let locationDetails: String
    let checkInType: String
}



```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Model/PostView.swift

```
////
////  PostView.swift
////  Fanzc
////
////  Created by Abdulaziz dot on 25/09/2024.
////
//
//
//// File: /Fanzc/Views/PostView.swift
//
//import SwiftUI
//
//struct PostView: View {
//    let post: Post
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 12) {
//            HStack {
//                ProfileImageView()
//                
//                VStack(alignment: .leading) {
//                    Text(post.author)
//                        .font(.headline)
//                    Text(post.timestamp, style: .relative)
//                        .font(.caption)
//                        .foregroundColor(.gray)
//                }
//                
//                Spacer()
//                
//                Button(action: {
//                    // TODO: Implement more options menu
//                }) {
//                    Image(systemName: "ellipsis")
//                        .foregroundColor(.gray)
//                }
//            }
//            
//            Text(post.content)
//                .font(.body)
//            
//            HStack {
//                Button(action: {
//                    // TODO: Implement like functionality
//                }) {
//                    Image(systemName: "heart")
//                        .foregroundColor(.gray)
//                }
//                
//                Button(action: {
//                    // TODO: Implement comment functionality
//                }) {
//                    Image(systemName: "bubble.right")
//                        .foregroundColor(.gray)
//                }
//                
//                Spacer()
//                
//                Button(action: {
//                    // TODO: Implement share functionality
//                }) {
//                    Image(systemName: "square.and.arrow.up")
//                        .foregroundColor(.gray)
//                }
//            }
//        }
//        .padding()
//        .background(Color.white)
//        .cornerRadius(12)
//        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
//    }
//}
//
//struct PostView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostView(post: Post(id: UUID(), author: "John Doe", content: "This is a sample post", timestamp: Date()))
//    }
//}
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Services/UserService.swift

```
//
//  UserService.swift
//  Fanzc
//
//  Created by Abdulaziz dot on 26/09/2024.
//

// File: UserService.swift
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class UserService {
    private let firestore = Firestore.firestore()

    func fetchUser(byID userID: String) {
        firestore.collection("users").document(userID).getDocument { document, error in
            if let document = document, document.exists {
                do {
                    let user = try document.data(as: User.self) // Requires User to conform to Decodable
                    // Use the decoded user
                } catch {
                    print("Error decoding user: \(error)")
                }
            } else {
                print("Document does not exist or there was an error: \(error?.localizedDescription ?? "unknown")")
            }
        }
    }

    func saveUser(_ user: User) {
        do {
            try firestore.collection("users").document(user.id).setData(from: user) // Requires User to conform to Encodable
        } catch {
            print("Error encoding user: \(error)")
        }
    }
}
  
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Services/PostService.swift

```
import Firebase
import FirebaseFirestoreSwift

class PostService: ObservableObject {
    private var db = Firestore.firestore()

    func fetchPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        print("Fetching posts...")
        db.collection("posts").order(by: "timestamp", descending: true).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching posts: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }

            guard let documents = querySnapshot?.documents else {
                print("No documents found")
                completion(.success([]))
                return
            }

            print("Found \(documents.count) documents")
            let posts = documents.compactMap { queryDocumentSnapshot -> Post? in
                do {
                    var post = try queryDocumentSnapshot.data(as: Post.self)
                    post.id = queryDocumentSnapshot.documentID
                    print("Successfully decoded post: \(post.id ?? "Unknown ID")")
                    return post
                } catch {
                    print("Error decoding post: \(error.localizedDescription)")
                    return nil
                }
            }
            print("Processed \(posts.count) posts")
            completion(.success(posts))
        }
    }

    func addPost(_ post: Post, completion: @escaping (Result<Post, Error>) -> Void) {
        do {
            let ref = try db.collection("posts").addDocument(from: post)
            var newPost = post
            newPost.id = ref.documentID
            print("Post added with ID: \(ref.documentID)")
            completion(.success(newPost))
        } catch {
            print("Error adding post: \(error.localizedDescription)")
            completion(.failure(error))
        }
    }

    func checkFirestoreConnection() {
        db.collection("posts").limit(to: 1).getDocuments { (snapshot, error) in
            if let error = error {
                print("Error connecting to Firestore: \(error.localizedDescription)")
            } else {
                print("Successfully connected to Firestore")
            }
        }
    }
}
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Services/FriendRequestService.swift

```
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class FriendRequestService: ObservableObject {
    @Published var friendRequests = [FriendRequest]()

    private let firestore = Firestore.firestore()

    func sendFriendRequest(from senderID: String, to receiverID: String, completion: @escaping (Error?) -> Void) {
        let friendRequest = FriendRequest(id: UUID().uuidString, senderID: senderID, receiverID: receiverID, status: "pending")
        do {
            try firestore.collection("friendRequests").document(friendRequest.id).setData(from: friendRequest)
            fetchFriendRequests(forUser: senderID)
            completion(nil)
        } catch {
            completion(error)
        }
    }

    func respondToRequest(requestID: String, status: String, completion: @escaping (Error?) -> Void) {
        firestore.collection("friendRequests").document(requestID).updateData(["status": status]) { error in
            completion(error)
        }
    }

    func fetchFriendRequests(forUser userID: String) {
        firestore.collection("friendRequests").whereField("receiverID", isEqualTo: userID).getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching friend requests: \(error)")
            } else {
                self.friendRequests = snapshot?.documents.compactMap { try? $0.data(as: FriendRequest.self) } ?? []
            }
        }
    }
}
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Services/addSamplePosts.swift

```
//
//  addSamplePosts.swift
//  Fanzc
//
//  Created by Abdulaziz dot on 26/09/2024.
//


// File: /Fanzc/Core/Services/PostService.swift (or similar path)

import Firebase
import FirebaseFirestoreSwift

class PostService: ObservableObject {
    @Published var posts: [Post] = []
    private var db = Firestore.firestore()

    // ... existing functions ...

    func addSamplePosts() {
        let samplePosts = [
            Post(authorID: "user1", authorName: "Alice", authorProfilePictureURL: "https://example.com/alice.jpg", content: "Hello, world!", timestamp: Date(), mediaURL: nil, likes: 0, comments: [], currentUserLiked: false),
            Post(authorID: "user2", authorName: "Bob", authorProfilePictureURL: "https://example.com/bob.jpg", content: "SwiftUI is awesome!", timestamp: Date(), mediaURL: nil, likes: 0, comments: [], currentUserLiked: false)
        ]
        
        for post in samplePosts {
            do {
                let _ = try db.collection("posts").addDocument(from: post)
                print("Successfully added sample post")
            } catch {
                print("Error adding sample post: \(error.localizedDescription)")
            }
        }
    }
}
```



# /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Services/UserDataStore.swift

```
//import Foundation
//import Firebase
//import FirebaseFirestoreSwift
//import Combine
//
//class UserDataStore: ObservableObject {
//    @Published var user: User
//    @Published var totalCheckIns: Int = 0
//    @Published var categoriesVisited: Int = 0
//    @Published var savedPlaces: Int = 0
//    @Published var visitedPlaces: Int = 0
//    @Published var streaks: Int = 0
//    @Published var mayorships: Int = 0
//    @Published var photos: [String] = []
//    @Published var checkIns: [CheckIn] = []
//    
//    private var db = Firestore.firestore()
//    private var listenerRegistration: ListenerRegistration?
//    private var cancellables = Set<AnyCancellable>()
//    
//    init(user: User) {
//        self.user = user
//        setupRealtimeListener()
//        fetchCheckIns()
//    }
//    
//    deinit {
//        listenerRegistration?.remove()
//    }
//    
//    private func setupRealtimeListener() {
//        guard let currentUser = Auth.auth().currentUser else {
//            print("No authenticated user")
//            return
//        }
//        
//        listenerRegistration = db.collection("users").document(currentUser.uid)
//            .addSnapshotListener { [weak self] documentSnapshot, error in
//                guard let document = documentSnapshot else {
//                    print("Error fetching document: \(error?.localizedDescription ?? "Unknown error")")
//                    return
//                }
//                guard let data = document.data() else {
//                    print("Document data was empty.")
//                    return
//                }
//                DispatchQueue.main.async {
//                    self?.updateUserData(with: data)
//                }
//            }
//    }
//    
//    private func updateUserData(with data: [String: Any]) {
//        self.user.username = data["username"] as? String ?? "Unknown"
//        self.user.bio = data["bio"] as? String ?? ""
//        self.user.profilePictureURL = data["profilePictureURL"] as? String
//        self.totalCheckIns = data["totalCheckIns"] as? Int ?? 0
//        self.categoriesVisited = data["categoriesVisited"] as? Int ?? 0
//        self.savedPlaces = data["savedPlaces"] as? Int ?? 0
//        self.visitedPlaces = data["visitedPlaces"] as? Int ?? 0
//        self.streaks = data["streaks"] as? Int ?? 0
//        self.mayorships = data["mayorships"] as? Int ?? 0
//        self.photos = data["photos"] as? [String] ?? []
//    }
//    
//    func fetchCheckIns() {
//        let postService = PostService()
//        postService.fetchPosts { [weak self] result in
//            switch result {
//            case .success(let posts):
//                DispatchQueue.main.async {
//                    self?.checkIns = posts.map { CheckIn(from: $0) }
//                    self?.visitedPlaces = self?.checkIns.count ?? 0
//                    self?.totalCheckIns = self?.checkIns.count ?? 0
//                    self?.updateUserDocument()
//                }
//            case .failure(let error):
//                print("Error fetching posts: \(error.localizedDescription)")
//            }
//        }
//    }
//    
//    func updateUserDocument() {
//        guard let currentUser = Auth.auth().currentUser else {
//            print("No authenticated user")
//            return
//        }
//        
//        db.collection("users").document(currentUser.uid).updateData([
//            "totalCheckIns": self.totalCheckIns,
//            "visitedPlaces": self.visitedPlaces
//        ]) { error in
//            if let error = error {
//                print("Error updating user document: \(error.localizedDescription)")
//            } else {
//                print("User document updated successfully")
//            }
//        }
//    }
//    
//    func updateProfile(username: String, bio: String) {
//        guard let currentUser = Auth.auth().currentUser else {
//            print("No authenticated user")
//            return
//        }
//        
//        db.collection("users").document(currentUser.uid).updateData([
//            "username": username,
//            "bio": bio
//        ]) { error in
//            if let error = error {
//                print("Error updating profile: \(error.localizedDescription)")
//            } else {
//                print("Profile updated successfully")
//                self.user.username = username
//                self.user.bio = bio
//            }
//        }
//    }
//    
//    func checkIn(at place: String) {
//        self.totalCheckIns += 1
//        self.visitedPlaces += 1
//        updateUserDocument()
//        
//        // Here you would also add the new check-in to Firestore
//        // and update the local checkIns array
//    }
//}
```



