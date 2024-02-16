//
//  Modifiers.swift
//  FlickerSearch
//
//  Created by shiva on 2/16/24.
//

import Foundation
import SwiftUI

struct CustomTitle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.black)
            .lineLimit(2)
            .font(.custom("Open Sans", size: 18))
            .padding(.leading)
    }
}

struct BodyStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.black)
            .lineLimit(5)
            .font(.custom("Open Sans", size: 16))
    }
}

extension Text {
    func customTitle() -> some View {
        self.bold()
            .modifier(CustomTitle())
    }
    
    func customBody() -> some View {
        self
        .modifier(BodyStyle())
    }
}
