//
//  UserCell.swift
//  Fanzc
//
//  Created by Abdulaziz dot on 30/11/2023.
//

import SwiftUI

struct UserCell: View {
    var body: some View {
        HStack{
           ProfileImageView()
            VStack(alignment: .leading) {
                
            
                Text("Khaled")
                    .font(.footnote)
                    .fontWeight(.semibold)
                
                Text("abdul12")
                    .font(.footnote)
            }
            Spacer()
            Text("Follow")
                .font(.subheadline)
                .fontWeight(.semibold)
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 32)
                .overlay{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray6), lineWidth:1)
                }
        }
        .padding(.horizontal)

    }
}

#Preview {
    UserCell()
}
