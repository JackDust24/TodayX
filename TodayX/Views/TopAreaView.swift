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
           
//            ZStack(alignment: .leading) {
//                TextField("Enter City name", text: self.$forecastViewModel.cityName) {
//                    self.forecastViewModel.searchCity()
//                }.padding(.all, 10)
//                    .frame(width: UIWidth - 50, height: 30)
//                    .background(Color("customBlue"))
//                    .cornerRadius(30)
//                    .foregroundColor(.white)
//                    .offset(x: self.showField ? 0 : (-UIWidth / 2 - 200), y: -40)
//                    .animation(.spring())
//                
//                Image(systemName: "magnifyingglass.circle.fill")
//                    .resizable()
//                    .frame(width: 24, height: 24)
//                    .foregroundColor(.white)
//                    .offset(x: self.showField ? (UIWidth - 95) : 0, y: -40)
//                    .animation(.spring())
//                    .onTapGesture {
//                        self.showField.toggle()
//                }
//            }.onAppear(perform: fetch)
//                .padding(.top, 40)
//            
//            //            Spacer()
//            //            VStack(alignment: .center) {
//            
//            Text("TODAY")
//                .foregroundColor(Color("customBlue"))
//                .font(.custom("Papyrus", size: 34))
//                .fontWeight(.light)
//                .offset(y: -20)
            
            ZStack {
                RoundedRectangle(cornerRadius: 10).stroke()
                    .foregroundColor(Color("customBlue"))
                
                VStack {
                    Text("\(self.forecastViewModel.currentCity), \(self.forecastViewModel.currentCountry)")
                        .foregroundColor(Color("customBlue"))
                        .font(.custom("Papyrus", size: 22))
                        //                          .font(.title).bold()
                        .fontWeight(.light)
                        .padding()
                       // .offset(y: 30)
                    Spacer()
                    
                    HStack(alignment: .top) {
                        
                        
                        VStack(alignment: .leading) {
                            Text("Temp")
                                .foregroundColor(Color("customBlue"))
                                .font(.custom("Arial Rounded MT Regular", size: 22))
                                .bold()
                               // .padding()
                                
                            
                            Text(self.forecastViewModel.temperature)
                                .foregroundColor(Color("customPurple"))
                                .font(.custom("Arial Rounded MT Bold", size: 24))
                                .bold()
                                //.offset(x: 10, y: -140)
                            
                            Image(systemName: Helper().showWeatherIcon(item: self.forecastViewModel.weatherResponse))
                                .resizable()
                                .frame(width: 40, height:  40, alignment: .center)
                                .foregroundColor(.white)
                              //  .offset(x: 30, y: -140)
                        }.padding()
                        
                        Spacer()

                        
                        VStack(alignment: .trailing) {
                            
                            Text("AQI")
                                .foregroundColor(Color("customBlue"))
                                .font(.custom("Arial Rounded MT Regular", size: 22))
                                .bold()
//                                .padding()
                            
                            Text(self.forecastViewModel.aqiData)
                                .foregroundColor(Color("customPurple"))
                                .font(.custom("Arial Rounded MT Bold", size: 24))
                                .bold()
                               // .offset(y: (UIHeight / 6))
                            Text(self.forecastViewModel.aqiConcernLevel)
                                .foregroundColor(Color("customPurple"))
                                .font(.custom("Arial Rounded MT Bold", size: 24))
                                .bold()
                                .offset(y: 20)
                        }.padding()
                        
                    }

                    
                  
//                    self.showReminder ? AnyView(Text("Reminder").offset(y: -60)) :
//                    AnyView(Text(""))
//
//                    Spacer()
                     // DO On toggle whether to show and notify the bottom area
               
//                    ImageButton(imageName: "heart.fill", size: CGSize(width: 60, height: 60))  {
//                                 }
//                        .offset(y: -100)
//
//                    Spacer()
                }
            }.padding()
            
            
        }
        //.padding(.leading, 20)
        
        //        }
        
        
    }
    //TODO: Delete this?
    private func fetch() {
        self.forecastViewModel.searchCity(userSearch: false)
    }
}

struct HighlightsView: View {
    
    var body: some View {
        Text("Hello Word")
    }
    
}

struct TopAreaView_Previews: PreviewProvider {

    static var previews: some View {
        
        ZStack {
            // Just for testing purposes only
            Color("customGreen")
            .edgesIgnoringSafeArea(.all)
            
            TopAreaView(showField: false, forecastViewModel: APIViewModel())
        }


    }
}
