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
                        NavigationLink(destination: Text("")) {
                            Text(self.forecastViewModel.currentCity ?? "Not Set").foregroundColor(Color.gray)
                            
                        }.fixedSize()
                        
                    }
                    
                }
                .navigationBarTitle("Settings", displayMode: .inline)
            }
        }
        
        
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
