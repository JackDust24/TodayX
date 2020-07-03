//
//  AddReminderView.swift
//  TodayX
//
//  Created by JasonMac on 16/6/2563 BE.
//  Copyright © 2563 Jason Whittaker. All rights reserved.
//

import SwiftUI

struct AddReminderView: View {
    
    @Binding var isPresented: Bool
    @State var addReminderVM = AddReminderVM()
    @State private var dateChosen = Date()
    
  
    // For dismissing a view.
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        NavigationView {
            
            Group {
                
                VStack {
                    
                    TextField("Enter Reminder", text: self.$addReminderVM.reminder)
                    
                    Picker(selection: self.$addReminderVM.tag, label: Text("")) {
                        Text("Urgent").tag("urg")
                        Text("Important").tag("imp")
                        Text("Normal").tag("nrm")
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    Text("Select a date")
                    
                    DatePicker(selection: $dateChosen, in: Date()..., displayedComponents: .date) {
                        Text("")
                    }

                    Button("Add Reminder", action:  {
                        // place reminder
                        let date = self.dateChosen
                        let convertDate = Helper().convertDateFromPickerWithoutTime(for: date)
                        print(convertDate)

                        
                        self.addReminderVM.date = convertDate
                        self.addReminderVM.saveReminder()
                        // self.isPresented = false
                        
                        self.presentationMode.wrappedValue.dismiss()
                        
                    }).padding(8)
                        .foregroundColor(Color.white)
                        .background(Color.green)
                        .cornerRadius(10)
                    
                    
                }
            }.padding()
                .navigationBarTitle("Add Reminder")
        }
    }
}

struct AddReminderView_Previews: PreviewProvider {
    static var previews: some View {
        AddReminderView(isPresented: .constant(false))
    }
}
