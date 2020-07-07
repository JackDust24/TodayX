//
//  ImageButton.swift
//  TodayX
//
//  Created by JasonMac on 18/6/2563 BE.
//  Copyright © 2563 Jason Whittaker. All rights reserved.
//

import Foundation
import SwiftUI

struct ImageButton: View {
    
    @State private var isPressed: Bool = false
    
    private var imageName: String

    private var onTap: () -> Void
  
    private var size: CGSize
    
    init(imageName: String, size: CGSize = CGSize(width: 60, height: 60), onTap: @escaping () -> Void) {
        
        self.imageName = imageName
        self.size = size
        self.onTap = onTap
    }
    
    var gray: Color {
        return Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
    }
    
    var white: Color {
        return Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    }
    
    var body: some View {
        
        Button(action: {
            
            self.isPressed = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.isPressed = false
                self.onTap()
            }
            
        }) {
            
            // SF Symbols or not

            Image(systemName: self.imageName)
                .resizable()
                    .frame(width: self.size.width, height: self.size.height)
                .padding(20)
                .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))


//            .foregroundColor(Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)))
            
        }.clipShape(Circle())
            .shadow(color: self.isPressed ? white : gray, radius: self.isPressed ? 4 : 8, x: 8, y: 8)
            .shadow(color: self.isPressed ? gray : white, radius: self.isPressed ? 4 : 8, x: -8, y: -8)
        .scaleEffect(self.isPressed ? 0.95 : 1.0)
        .animation(.spring())
        
    }
}

struct ImageButton_Previews: PreviewProvider {
    static var previews: some View {
        ImageButton(imageName: "Spiral") {}
    }
}
