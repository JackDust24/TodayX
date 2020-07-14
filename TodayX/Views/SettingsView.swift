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
            //MARK" Settings View
            Form {
                Section(header: Text("Change the default location here. This will show the temperature and AQI index for the default city.")) {
                    HStack {
                        Text("Default Location")
                        Spacer()
                        NavigationLink(destination: LocationDefaultsView(forecastViewModel: self.forecastViewModel)) {
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

// When user selects details about the City defaults
struct LocationDefaultsView: View {
    
    @State private var name: String = ""
    @ObservedObject var forecastViewModel: APIViewModel
    @State private var responseConfirmingLocationFound = false
    @State private var showingAlert = false
    
    let cityResponse = NotificationCenter.Publisher(center: .default, name: .responseForCity, object: nil)
    let noCityResponse = NotificationCenter.Publisher(center: .default, name: .noResponseForCity, object: nil)
    
    var body: some View {
        
        Group {
            VStack {
                // MARK: Show Location
                HStack {
                    Text("Current Location - ")
                    Text(self.forecastViewModel.returnDefaultCity()).foregroundColor(Color.gray)
                    
                }.padding()
                    .onAppear(perform: fetch)
                
                // MARK: Set new location
                Text("New Location - ")
                
                TextField("Enter City Name", text: $name) {
                    self.forecastViewModel.cityName = self.name
                    self.forecastViewModel.searchCity(userSearch: true)
                    
                }.textFieldStyle(RoundedBorderTextFieldStyle())
                
            }.onReceive(cityResponse)
            { obj in
                // Abstract the city name
                let city = obj.object
                self.forecastViewModel.saveCityLocationAsDefault(cityName: city as! String)
                self.responseConfirmingLocationFound = true
                self.showingAlert = true
                
            }
            .onReceive(noCityResponse)
            { _ in
                self.responseConfirmingLocationFound = false
                self.showingAlert = true
                self.name = ""
            }
            .alert(isPresented: $showingAlert) {
                return alertToReturn(cityFound: responseConfirmingLocationFound)
            }
        }
    }
    
    private func fetch() {
        // We want to automatically fetch current details, without it being a user search.
        self.forecastViewModel.searchCity(userSearch: false)
    }
    
    private func alertToReturn(cityFound response: Bool) -> Alert {
        // If a response that the city exists etc, then set as default or message user there is no city
        if response {
            return Alert(title: Text(kCityDefault), message: Text(kCityDefaultMessage), dismissButton: .default(Text("Ok!")))
        } else {
            return
                Alert(title: Text(kUnknown), message: Text(kUnknownMessage), dismissButton: .default(Text("Ok!")))
        }
        
        
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
