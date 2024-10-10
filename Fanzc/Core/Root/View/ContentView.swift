import SwiftUI
// If FanzcTabView is in a different module, import it here
// import YourModuleName

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        Group {
            if let userSession = viewModel.userSession {
                FanzcTabView(user: userSession)
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
