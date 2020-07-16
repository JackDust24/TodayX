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
// Color(kMainTextColour)
        }.navigationBarTitle("Settings", displayMode: .inline)
                .background(NavigationConfigurator { nc in
                    nc.navigationBar.barTintColor = UIColor.init(displayP3Red: 0.475, green: 0.745, blue: 0.9333, alpha: 1.0)
                    nc.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.systemBlue]
                })
            }
        .navigationViewStyle(StackNavigationViewStyle())
        
        
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
            
            ZStack {

                Color(kCustomBackgroundColour)
                
                VStack {
                    // MARK: Show Location
                   
                    HStack {
                        Text("Current Location - ")
                        Text(self.forecastViewModel.returnDefaultCity()).foregroundColor(Color.black)
                        
                    }.padding()
                        .onAppear(perform: fetch)
                    
                    // MARK: Set new location
                    Text("New Location - ")
                    
                    TextField("Enter City Name", text: $name) {
                        self.forecastViewModel.cityName = self.name
                        self.forecastViewModel.searchCity(userSearch: true)
                        
                    }.textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: UIWidth - 40, height: 60, alignment: .center)
                    
                    Spacer()

                   
                    }.padding()
                    .onReceive(cityResponse)
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

            }.foregroundColor(Color(kMainTextColour))
            
        }
    }
    
    private func fetch() {
        // We want to automatically fetch current details, without it being a user search.
        self.forecastViewModel.searchCity(userSearch: false)
    }
    
    private func alertToReturn(cityFound response: Bool) -> Alert {
        // If a response that the city exists etc, then set as default or message user there is no city
        if response {
            return Alert(title: Text(kCityDefaultAlert), message: Text(kCityDefaultMessageAlert), dismissButton: .default(Text("Ok!")))
        } else {
            return
                Alert(title: Text(kUnknownAlert), message: Text(kUnknownMessageAlert), dismissButton: .default(Text("Ok!")))
        }
    }
}

// Th is sets the colour of the Navigation bar
struct NavigationConfigurator: UIViewControllerRepresentable {
    
    var configure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }

}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
