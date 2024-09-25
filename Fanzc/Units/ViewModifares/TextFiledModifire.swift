//
//  TextFiledModifire.swift
//  Fanzc
//
//  Created by Abdulaziz dot on 30/11/2023.
//

import SwiftUI

struct TextFiledModifire: ViewModifier {
    
    func body(content: Content) -> some View {
        content
                  .padding(8)
                  .background(Color.white.opacity(0.2))
                  .cornerRadius(20)
                  .padding(.horizontal)
          }
      }

      extension View {
          func customTextField() -> some View {
              self.modifier(TextFiledModifire())
          }
      }
