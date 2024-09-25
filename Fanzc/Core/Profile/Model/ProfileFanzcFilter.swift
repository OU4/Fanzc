//
//  ProfileFanzcFilter.swift
//  Fanzc
//
//  Created by Abdulaziz dot on 30/11/2023.
//

import Foundation

enum ProfileFanzcFilter: Int, CaseIterable, Identifiable {
    case posts
    case media
    
    var title: String {
        switch self{
        case .posts: return "Posts"
        case .media: return "Media"
        }
    }
    
    var id: Int {return self.rawValue}
}
