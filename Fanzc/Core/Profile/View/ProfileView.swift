import SwiftUI

struct ProfileView: View {
    @State private var selectedFilter: ProfileFanzcFilter = .posts
    @Namespace var animation

    var body: some View {
        
        NavigationStack{
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            
                            ProfileImageView()
                            
                            HStack {
                                
                                VStack(alignment: .leading) {
                                    Text("Khaled Ahmed")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                    
                                    Text("Khaled_Ahmed")
                                        .font(.subheadline)
                                    
                                    Text("الجمال والاناقه")
                                        .font(.subheadline)
                                    
                                }

                                Spacer()

                                Button(action: {
                                    // Follow button action
                                }, label: {
                                    Text("Follow")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.black)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 5)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(Color.black, lineWidth: 1)
                                        )
                                    
                                })
                                
                               
                                
                            }
                            
                            

                            Text("Best swift programmer in Saudi")
                                .font(.footnote)
                            
                            Text("2 followers")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }

                        Spacer()

                        
                    }

                    Button(action: {
                        // Ask button action
                    }, label: {
                        Text("Subscribe")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 352, height: 50)
                            .background(.black)
                            .cornerRadius(10)
                    })
                    .padding(.top)

                    // User content list view
                    VStack {
                        HStack {
                            
                            ForEach(ProfileFanzcFilter.allCases) { filter in
                                VStack {
                                    Text(filter.title)
                                        .font(.subheadline)
                                        .fontWeight(selectedFilter == filter ? .semibold : .regular)

                                    if selectedFilter == filter {
                                        Rectangle()
                                            .foregroundColor(.black)
                                            .frame(width: 180, height: 1)
                                            .matchedGeometryEffect(id: "item", in: animation)
                                    } else {
                                        Rectangle()
                                            .foregroundColor(.clear)
                                            .frame(width: 180, height: 1)
                                        
                                    }
                                    
                                }
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        selectedFilter = filter
                                    }
                                }
                            }
                        }
                        
                        ForEach(0 ... 10, id: \.self) { _ in
                            PostCell()
                        }
                    }
                }
                .toolbar{
                    
                    ToolbarItem(placement: .navigationBarTrailing){
                        
                        Button {
                            
                            AuthService.shared.signOut()
                            
                        }label:{
                            
                            Image(systemName: "line.3.horizontal")
                        }
                    }
                    
                }
                .padding(.bottom)
                .padding(.horizontal)
            }
        }
        
    }
}

// Add your ProfileImageView, PostsCell, and other required components here

// Preview
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
