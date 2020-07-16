//
//  TopView.swift
//  TodayX
//
//  Created by JasonMac on 16/6/2563 BE.
//  Copyright © 2563 Jason Whittaker. All rights reserved.
//

import SwiftUI

struct TopView: View {
    
    //MARK: Properties
    @State private var showingAlertForUnknownCity = false
    @State var showField: Bool = false // For the spring textfield to show
    @State private var cityName: String = ""
    // View Model
    @ObservedObject var forecastViewModel: APIViewModel

    // Notifcation
    let noCityResponse = NotificationCenter.Publisher(center: .default, name: .noResponseForCity, object: nil)
    //    let pub = NotificationCenter.default
//        .publisher(for: NSNotification.Name("NoResponse"))
    
    var body: some View {
        
        VStack  {
            ZStack(alignment: .leading) {
                //MARK: Search for City Location
                TextField("Enter City Name", text: $cityName) {
                    self.forecastViewModel.cityName = self.cityName
                    self.forecastViewModel.searchCity(userSearch: true)
                }.padding(.all, 10)
                    .frame(width: UIWidth - 50, height: 30)
                    .background(Color("customBabyBlueEyes"))
                    .cornerRadius(30)
                    .foregroundColor(.blue)
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
                .padding(.top, 60)
                .onReceive(noCityResponse)
                { obj in
                    self.showingAlertForUnknownCity = true
                    self.cityName = ""
                    
            }.alert(isPresented: $showingAlertForUnknownCity) {
                Alert(title: Text(kUnknownAlert), message: Text(kUnknownMessageAlert), dismissButton: .default(Text("Ok!")))
            }
            Spacer()
            //MARK: Title of app
            Text(kTodayCAP)
                .foregroundColor(Color(kMainTextColour))
                .font(.custom("Papyrus", size: 48))
                .fontWeight(.heavy)
                .offset(y: -40)
            Spacer()
        }
    
    }
    
    private func fetch() {
        self.forecastViewModel.searchCity(userSearch: false)
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
