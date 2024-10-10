import SwiftUI

struct FanzcTabView: View {
    let user: User
    
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
            
            ProfileView(user: user)
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}
