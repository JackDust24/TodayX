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
            //MARK: Info View
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
            }.navigationBarTitle("Info", displayMode: .inline)
                
            //TODO: This causes the tab bar to become white again.
//                            .background(NavigationConfigurator { nc in
//
//                                nc.navigationBar.barTintColor = UIColor.init(displayP3Red: 0.475, green: 0.745, blue: 0.9333, alpha: 1.0)
//                                nc.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.systemBlue]
//                            })
        }
     //           .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func fetch() {
        print("fetch")
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
                
                Color.init(UIColor(named: kVeryLightBlueColour)!)
                    .opacity(0.5)
                
                VStack {
                    // MARK: Show Location
                    
//                    HStack(alignment: .firstTextBaseline) {
//                        Text("Current Location - ")
//                            .font(.subheadline)
//                        Text(self.forecastViewModel.returnDefaultCity()).foregroundColor(Color.black)
//                            .font(.title)
//
//                    }

                    
                    // MARK: Set new location
                    
                    Spacer()
                    
                    Text("Enter New Location Below")
                        .font(.title)
                    
                    TextField("Enter City Name", text: $name) {
                        self.forecastViewModel.location = self.name
                        self.forecastViewModel.searchCity(userSearch: true)
                        
                    }
                        .padding(EdgeInsets(top: 8, leading: 16,
                                            bottom: 8, trailing: 16))
                        .background(Color.white).cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(lineWidth: 2)
                                .foregroundColor(.blue)
                            
                        )
                        .shadow(color: Color.gray.opacity(0.4),
                                radius: 3, x: 1, y: 2)
                        
                    VStack {
                        Text("Current Location:  ")
                            .font(.subheadline)
                            .padding(.bottom, 5)
                        Text(self.forecastViewModel.returnDefaultCity()).foregroundColor(Color.black)
                            .font(.subheadline)
                        
                    }
                    .padding()
                        .onAppear(perform: fetch)
                    
                    Spacer()
                  //  Spacer()
                    
                    
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
                .offset(y: -60)
                
            }.foregroundColor(Color("customBlue"))
            
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
        print("CONFIG")

        if let nc = uiViewController.navigationController {
            print("CONFIG2")

            self.configure(nc)
        }
    }
    
}



struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(forecastViewModel: APIViewModel())
    }
}


//struct LocationDefaultsView_Previews: PreviewProvider {
//    static var previews: some View {
//        LocationDefaultsView(forecastViewModel: APIViewModel())
//    }
//}
