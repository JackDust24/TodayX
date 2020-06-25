//
//  TopView.swift
//  TodayX
//
//  Created by JasonMac on 16/6/2563 BE.
//  Copyright © 2563 Jason Whittaker. All rights reserved.
//

import SwiftUI



struct TopView: View {
    
    @State var showField: Bool = false
    @ObservedObject var forecastViewModel: APIViewModel
    
    var body: some View {
        
        
        VStack  {
            
            ZStack(alignment: .leading) {
                TextField("Enter City name", text: self.$forecastViewModel.cityName) {
                    self.forecastViewModel.searchCity()
                }.padding(.all, 10)
                    .frame(width: UIWidth - 50, height: 30)
                    .background(Color("customBlue"))
                    .cornerRadius(30)
                    .foregroundColor(.white)
                    .offset(x: self.showField ? 0 : (-UIWidth / 2 - 200), y: -40)
                    .animation(.spring())
                
                Image(systemName: "magnifyingglass.circle.fill")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.white)
                    .offset(x: self.showField ? (UIWidth - 95) : 0, y: -40)
                    .animation(.spring())
                    .onTapGesture {
                        self.showField.toggle()
                }
                 Spacer()
            }.onAppear(perform: fetch)
                .padding(.top, 60)
           // Spacer()
            
            Text("TODAY")
                .foregroundColor(Color("customBlue"))
                .font(.custom("Papyrus", size: 34))
                .fontWeight(.light)
                .offset(y: -20)
                //.padding(.top, 100)
           Spacer()
           // Spacer()
        }
        

    }
    
    private func fetch() {
        self.forecastViewModel.searchCity()
    }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        
        ZStack {
            // Just for testing purposes only
            Color("customGreen")
            .edgesIgnoringSafeArea(.all)
        
            TopView(forecastViewModel: APIViewModel())
        }
    }
}
