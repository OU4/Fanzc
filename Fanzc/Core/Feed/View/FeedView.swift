import SwiftUI

struct FeedView: View {
    @State private var searchText = ""
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: 0) {
                    TopBarView()
                    SearchBarView(searchText: $searchText)
                    LocationHeaderView()
                    TimelineView()
                }
            }
            .edgesIgnoringSafeArea(.top)
            
            AddPostButton()
        }
    }
}

struct TopBarView: View {
    var body: some View {
        ZStack {
            Color.red
            HStack {
                Text("Path")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                HStack(spacing: 20) {
                    Image(systemName: "clock")
                    Image(systemName: "globe")
                    Image(systemName: "person.2")
                    Image(systemName: "heart")
                }
            }
            .foregroundColor(.white)
            .padding(.horizontal)
        }
        .frame(height: 44)
    }
}

struct SearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search Timeline", text: $searchText)
            Image(systemName: "paperplane.fill")
        }
        .padding(8)
        .background(Color.white)
        .cornerRadius(20)
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color.blue.opacity(0.1))
    }
}

struct LocationHeaderView: View {
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image("landscape")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .clipped()
            
            HStack {
                Image("profile")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text("South Jakarta")
                        .font(.headline)
                    Text("Morning")
                        .font(.subheadline)
                }
            }
            .foregroundColor(.white)
            .padding()
        }
    }
}

struct TimelineView: View {
    var body: some View {
        VStack(spacing: 0) {
            TimelineItemView(images: ["friend1", "friend2"], text: "Friends with Albert Flores", count: "3")
            TimelineItemView(images: ["profile"], text: "Changed his picture", count: "10")
            TimelineItemView(images: ["friend3", "friend4"], text: "Friends with Theresa Webb", count: "50")
            TimelineItemView(images: ["music"], text: "Listening to Tinder Song by VICTOR!", subtitle: "Tinder Song • Single, 2017", count: "50")
            TimelineItemView(images: ["profile"], text: "Kathryn Sway")
        }
    }
}

struct TimelineItemView: View {
    let images: [String]
    let text: String
    let subtitle: String?
    let count: String?
    
    init(images: [String], text: String, subtitle: String? = nil, count: String? = nil) {
        self.images = images
        self.text = text
        self.subtitle = subtitle
        self.count = count
    }
    
    var body: some View {
        HStack {
            ZStack {
                ForEach(0..<images.count, id: \.self) { index in
                    Image(images[index])
                        .resizable()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                        .offset(x: CGFloat(index * 15))
                }
            }
            .frame(width: 40 + CGFloat((images.count - 1) * 15), height: 40)
            
            VStack(alignment: .leading) {
                Text(text)
                    .font(.subheadline)
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            if let count = count {
                Text(count)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
    }
}

struct AddPostButton: View {
    var body: some View {
        Button(action: {}) {
            Image(systemName: "plus")
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 60, height: 60)
                .background(Color.red)
                .clipShape(Circle())
                .shadow(radius: 5)
        }
        .padding(.bottom, 60)
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
