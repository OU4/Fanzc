import SwiftUI

struct fanzcTabView: View {
    var user: User // Make sure to pass this from a higher-level view or view model

    var body: some View {
        TabView {
            FeedView()
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
            
            ProfileView(user: user) // Pass the user parameter here
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}
