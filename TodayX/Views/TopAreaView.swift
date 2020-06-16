//
//  TopAreaView.swift
//  TodayX
//
//  Created by JasonMac on 16/6/2563 BE.
//  Copyright © 2563 Jason Whittaker. All rights reserved.
//

import SwiftUI

let UIWidth = UIScreen.main.bounds.width
let UIHeight = UIScreen.main.bounds.height

struct TopAreaView: View {
    // Properties for showing the City and the the Forecast
    @State var showField: Bool = false
    @ObservedObject var forecastViewModel: APIViewModel
    
    var body: some View {
        
        VStack {
            
//            ZStack {
//                RoundedRectangle(cornerRadius: 25)
//                    .frame(width: UIWidth, height: UIHeight / 3)
//                    .offset(x: 0, y: 40)
//                    .foregroundColor(Color("customVLBlue"))
//                    .opacity(0.4)
                
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
                }.onAppear(perform: fetch)
                    .padding(.top, 40)
            
//            Spacer()
//            VStack(alignment: .center) {
            
            Text("TODAY")
                .foregroundColor(Color("customBlue"))
                .font(.custom("Papyrus", size: 34))
                .fontWeight(.light)
                .offset(y: -20)
            
                      Text("\(self.forecastViewModel.currentCity), \(self.forecastViewModel.currentCountry)")
                          .foregroundColor(Color("customBlue"))
            .font(.custom("Papyrus", size: 22))
//                          .font(.title).bold()
                          .fontWeight(.light)
                          .offset(y: 30)
                      
                      
//                      Text(self.forecastViewModel.weatherDay)
//                          .foregroundColor(Color("customBlue"))
//                          .font(.system(size: 15))
//                          .bold()
//                          .offset(y: -180)
                      //Spacer()

                      }
        //.padding(.leading, 20)
                  
//        }
        

    }
    
    private func fetch() {
        self.forecastViewModel.searchCity()
    }
}

//struct TopAreaView_Previews: PreviewProvider {
//
//    static var previews: some View {
//
//        TopAreaView(showField: false, forecastViewModel: nil)
//    }
//}
