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
