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
