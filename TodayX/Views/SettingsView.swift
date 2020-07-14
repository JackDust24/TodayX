//
//  SettingsView.swift
//  TodayX
//
//  Created by JasonMac on 10/7/2563 BE.
//  Copyright © 2563 Jason Whittaker. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var forecastViewModel: APIViewModel
    
    var body: some View {
        
        NavigationView {
            
            Form {
                Section(header: Text("Change the default location here. This will show the temperature and AQI index for the default city.")) {
                    HStack {
                        Text("Default Location")
                        Spacer()
                        NavigationLink(destination: SettingsDetailView(forecastViewModel: self.forecastViewModel)) {
                            Text(self.forecastViewModel.returnDefaultCity()).foregroundColor(Color.gray)
                            
                            
                        }.fixedSize()
                        
                    }.onAppear(perform: fetch)
                    
                }
                .navigationBarTitle("Settings", displayMode: .inline)
            }
        }
        
        
    }
    
    private func fetch() {
        self.forecastViewModel.searchCity(userSearch: false)
    }
}

struct SettingsDetailView: View {
    
    @State private var name: String = ""
    @ObservedObject var forecastViewModel: APIViewModel
    @State private var showingAlertForResponse = false
    //private var showingAlertForNonResponse = false
    @State private var showingAlert = false

//    let noCityResponse = NotificationCenter.default
//        .publisher(for: NSNotification.Name("NoResponse"))
//    let CityResponse = NotificationCenter.default
//        .publisher(for: NSNotification.Name("Response"))
    let cityResponse = NotificationCenter.Publisher(center: .default, name: .responseForCity, object: nil)
     let noCityResponse = NotificationCenter.Publisher(center: .default, name: .noResponseForCity, object: nil)
    
    var body: some View {
        
        Group {
            VStack {
                HStack {
                    
                    Text("Current Location - ")
                    Text(self.forecastViewModel.returnDefaultCity()).foregroundColor(Color.gray)
                    
                }.padding()
                    .onAppear(perform: fetch)
                
                Text("New Location - ")
                
                TextField("Enter City Name", text: $name) {
                    print("City Name Change - \(self.name)")
                    
                    self.forecastViewModel.cityName = self.name
                    self.forecastViewModel.searchCity(userSearch: true)
                }.textFieldStyle(RoundedBorderTextFieldStyle())
            }.onReceive(cityResponse)
            { obj in
                self.showingAlertForResponse = true
                print("NOTIFICATION response received")
                self.showingAlert = true
                
                // Abstract the city name
//                let city = obj.userInfo?.first?.value
                let city = obj.object
                self.forecastViewModel.saveCityLocationAsDefault(cityName: city as! String)

            }
            .onReceive(noCityResponse)
            { obj in
//                self.showingAlertForNonResponse = true
                self.showingAlertForResponse = false
                self.showingAlert = true
                print("NOTIFICATION no response received")
                self.name = ""
                }
            .alert(isPresented: $showingAlert) {
                    print("Show Alert - Response? - \(showingAlertForResponse)")
                
                    return alertToReturn(cityFound: showingAlertForResponse)
   
                }
            
            
        }
        //        Text(self.forecastViewModel.returnDefaultCity()).foregroundColor(Color.gray)
        
    }
    
    private func fetch() {
        self.forecastViewModel.searchCity(userSearch: false)
    }
    
    private func alertToReturn(cityFound response: Bool) -> Alert {
        print("ALERT CALLED - \(response)")
        
        

         if response {
            return Alert(title: Text("Saved Default City"), message: Text("This is now stored as your default location"), dismissButton: .default(Text("Ok!")))
        } else {
            return
                Alert(title: Text("Unknown City"), message: Text("No City Found, Try Again"), dismissButton: .default(Text("Ok!")))
        }
        
        
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
