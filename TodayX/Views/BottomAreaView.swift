//
//  BottomAreaView.swift
//  TodayX
//
//  Created by JasonMac on 16/6/2563 BE.
//  Copyright © 2563 Jason Whittaker. All rights reserved.
//

import SwiftUI

struct BottomAreaView: View {
    
    // This will be separate, with a model.
    @ObservedObject var testReminder: RemindersHomePageVM
    
    // For showing the Reminder View
    @State private var showReminder: Bool = false
    
    var body: some View {
        
        VStack {
            ZStack {
                
                Button(action: {
                    
                    self.showReminder.toggle()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        //self.showReminder = false
                        
                        // self.onTap()
                    }
                    
                }) {
                    
                    Image("Spiral").renderingMode(.original)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .padding()
                        .shadow(color: Color(#colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)), radius: 8, x: 9, y: 9)
                        .shadow(color: Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)), radius: 8, x: -9, y: -9)
                }.padding()
                    .clipShape(Circle().inset(by: 6))
                    .offset(y: -210)
                    .shadow(color: Color(#colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)), radius: 10, x: 9, y: 9)
                    .shadow(color: Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)), radius: 10, x: -9, y: -9)
                
                RoundedRectangle(cornerRadius: 10).stroke()
                    .foregroundColor(Color("customBlue"))
                    .frame(width: UIWidth - 40, height: UIHeight / 3 - 66)
                Spacer()
                
                VStack {
                    
                    Text("Reminders").padding(20)
                    //                    Divider()
                    self.showReminder ? AnyView(Text("\(testReminder.returnReminders)").frame(width: UIWidth - 40, height: 60)) :
                        AnyView(Text("\(testReminder.returnReminders)").frame(width: UIWidth - 40, height: 60))
                    
                    
                }
                .offset(y: -30)
                .padding()
                
                
            }
            //                .padding(.bottom, 60)
            //            }.onTapGesture {
            //                // HighlightsView()
            //                self.showReminder.toggle()
            //            }
            
            
            
        }
        
        
    }
}

struct BottomAreaView_Previews: PreviewProvider {
    static var previews: some View {
        BottomAreaView(testReminder: RemindersHomePageVM())
    }
}
