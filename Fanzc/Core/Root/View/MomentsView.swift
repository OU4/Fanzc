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
