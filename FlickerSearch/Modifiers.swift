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
            .font(.custom("Open Sans", size: 18))
            .frame(height: 28)
    }
}

struct BodyStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.black)
            .font(.custom("Open Sans", size: 16))
            .frame(height: 28)
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
