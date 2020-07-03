//
//  AddEditReminderView.swift
//  TodayX
//
//  Created by JasonMac on 3/7/2563 BE.
//  Copyright © 2563 Jason Whittaker. All rights reserved.
//

import SwiftUI

struct EditReminderView: View {
    
    var isEditedReminder: Bool
    var reminderObject: ReminderViewModel
    
    init(isEditedReminder: Bool, reminderObject: ReminderViewModel) {
        self.isEditedReminder = isEditedReminder
        self.reminderObject = reminderObject
    }
    
    var reminder: String {
        reminderObject.reminder
    }
    
    var typeString: Int {
        reminderObject.type
        // Call a function by sending Int and return string
        // Change to a string
        //
    }
    
    var date: Date {
        // Convert the date to a string
        reminderObject.date
    }
    
    var uuid: UUID {
        reminderObject.id
    }
    
    // For dismissing a view.
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            AddEditReminderView(isEditedReminder: isEditedReminder, reminder: reminder, typeString: "typString", dateString: "dateString", id: uuid, presentationMode: presentationMode)
            
        }.padding()
        .navigationBarTitle("Edit Reminder")
        
    }
}

struct Add2ReminderView: View {
    
    @Binding var isPresented: Bool
    @State var addReminderVM = AddReminderVM()
    @State private var dateChosen = Date()
    // For Edit and does not need to be called but sets default values.
    let isEditedReminder: Bool = false
    let reminder: String? = nil
    let type: String? = nil
    let date: Date? = nil
    
    
    // For dismissing a view.
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AddEditReminderView: View {
    
    @State var addReminderVM = AddReminderVM()
    @State private var dateChosen = Date()
    var isEditedReminder: Bool
    var reminder: String
    var typeString: String
    var dateString: String
    var id: UUID
    
    var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        Group {
            
            VStack {
                
                TextField(isEditedReminder ? "\(reminder)" : "Enter Reminder", text: self.$addReminderVM.reminder)
                
                Spacer()

//                if isEditedReminder {
//                    Text("Change the urgency. Current setting: \(typeString)")
//                }
               // Spacer()

                Picker(selection: self.$addReminderVM.tag, label: Text("")) {
                    Text("Urgent").tag("urg")
                    Text("Important").tag("imp")
                    Text("Normal").tag("nrm")
                }.pickerStyle(SegmentedPickerStyle())
              
                if isEditedReminder {
                    Text("Change the date. Current date: \(dateString)")
                }
                                
                Text("Select a date")
                
                DatePicker(selection: $dateChosen, in: Date()..., displayedComponents: .date) {
                    Text("")
                }
                
                Button(isEditedReminder ? "Save Changes" : "Add Reminder", action:  {
                    // place reminder
                    let date = self.dateChosen
                    let convertDate = Helper().convertDateFromPickerWithoutTime(for: date)
                    print(convertDate)
                                        
                    self.addReminderVM.date = convertDate
                    
                    if self.isEditedReminder {
                        self.addReminderVM.id = self.id
                        if self.addReminderVM.reminder.isEmpty {
                            self.addReminderVM.reminder = self.reminder
                        }
                        self.addReminderVM.updateReminder()
                    } else {
                     self.addReminderVM.saveReminder()

                    }
                    // self.isPresented = false
                    
                    self.presentationMode.wrappedValue.dismiss()
                    
                }).padding(8)
                    .foregroundColor(Color.white)
                    .background(Color.green)
                    .cornerRadius(10)
                
                
            }
        }
    }
}

//struct AddEditReminderView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddEditReminderView()
//    }
//}
