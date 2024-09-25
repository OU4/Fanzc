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
            if viewModel.userSession != nil {
                
                fanzcTabView()
                
            }else {
                
                LoginView()
                
            }
        }
    }
}

#Preview {
    ContentView()
}
