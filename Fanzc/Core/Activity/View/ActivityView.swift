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
