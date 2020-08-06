//
//  TopAreaView.swift
//  TodayX
//
//  Created by JasonMac on 16/6/2563 BE.
//  Copyright © 2563 Jason Whittaker. All rights reserved.
//

import SwiftUI

//MARK: Global properties
let UIWidth = UIScreen.main.bounds.width
let UIHeight = UIScreen.main.bounds.height

struct APIResultsView: View {
    //MARK: Properties for showing the City and the the Forecast
//    @State var showField: Bool = false
    @ObservedObject var forecastViewModel: APIViewModel
    
    // This is for showing the latest reminders
   @ObservedObject var reminderListVM: ReminderListVM
    
//    init() {
//        //self._showReminder = showReminder
//        self.forecastViewModel = APIViewModel()
//          self.reminderListVM = ReminderListVM()
//      }
    // For showing the Reminder View
    @Binding var showNewReminder: Bool
    
    var body: some View {
          
        VStack {
            ZStack {
                // MARK: City Details
                RoundedRectangle(cornerRadius: 10).stroke()
                    .foregroundColor(Color("customBlue"))
                
                VStack {
                    Text("\(self.forecastViewModel.currentCity), \(self.forecastViewModel.currentCountry)")
                        .foregroundColor(Color(kMainTextColour))
                        //.font(.custom("Papyrus", size: 36))
                        .fontWeight(.heavy)
                        .padding(5)
                        .scaledFont(name: "Papyrus", size: 26)
                    
                    HStack(alignment: .top) {
                        // MARK: The Temperature Details
                        VStack(alignment: .leading) {
                            Text("Temp")
                                .foregroundColor(Color(kMainTextColour))
                                .font(.custom("Raleway-Medium", size: 22))
                                .bold()
                                .padding(.bottom, 10)
                            
                            Text(self.forecastViewModel.temperature)
                                .foregroundColor(Color(kSubTextColour))
                                .font(.custom("Raleway-Medium", size: 24))
                                .bold()
                                .padding(.leading, 3)

                            Image(systemName: Helper().showWeatherIcon(item: self.forecastViewModel.weatherResponse))
                                .resizable()
                                .frame(width: 40, height:  40, alignment: .center)
                                .foregroundColor(.white)
                              .padding(.leading, 3)
                        }.padding()
                        
                        Spacer()

                        // MARK: AQI Index Details
                        VStack(alignment: .trailing) {
                            
                            Text("AQI")
                                .foregroundColor(Color(kMainTextColour))
                                .font(.custom("Raleway-Medium", size: 22))
                                .bold()
                                .padding(.bottom, 10)

                            Text(self.forecastViewModel.aqiData)
                                .foregroundColor(Color(kSubTextColour))
                                .font(.custom("Raleway-Medium", size: 24))
                                .bold()
                                .padding(.trailing, 3)

                            Text(self.forecastViewModel.aqiConcernLevel)
                                .foregroundColor(Color(kSubTextColour))
                                .font(.custom("Raleway-Medium", size: 24))
                                .bold()
                                .padding(.trailing, 3)
                                .offset(y: 10)
                        }.padding()
                    }
                }
                
                Button(action: {
                    // User clicks button to show the reminder
                    self.showNewReminder.toggle()
                    print("Reminder Check Pre - \(self.reminderListVM.summaryReminder), count - \(self.reminderListVM.reminders.count)")

                    self.reminderListVM.returnReminder()
                    print("Reminder - \(self.showNewReminder)")
                    print("Reminder Check Post - \(self.reminderListVM.summaryReminder)")


                }) {
                    
                    Image("Spiral").renderingMode(.original)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .padding()
                        .shadow(color: Color(kFranceBlueColour), radius: 8, x: 9, y: 9)
                        .shadow(color: Color(kJeansBlueColour), radius: 8, x: -9, y: -9)
                }.padding()
                    .clipShape(Circle().inset(by: 6))
                    //.offset(y: -UIHeight / 2)
                    .shadow(color: Color(kFranceBlueColour), radius: 10, x: 9, y: 9)
                    .shadow(color: Color(kJeansBlueColour), radius: 10, x: -9, y: -9)
                    .accessibility(identifier: "ImageButton")
                
               
             
            }.padding()
         
            Spacer()
        }
        
    }

}

//struct TopAreaView_Previews: PreviewProvider {
//
//    static var previews: some View {
//
//        ZStack {
//            // Just for testing purposes only
//            Color("customGreen")
//            .edgesIgnoringSafeArea(.all)
//            TopAreaView(forecastViewModel: APIViewModel(), showReminder: false)
//        }
//    }
//}
