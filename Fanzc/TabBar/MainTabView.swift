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
