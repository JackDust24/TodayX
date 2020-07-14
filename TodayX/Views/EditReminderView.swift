//
//  AddEditReminderView.swift
//  TodayX
//
//  Created by JasonMac on 3/7/2563 BE.
//  Copyright © 2563 Jason Whittaker. All rights reserved.
//

import SwiftUI

struct EditReminderView: View {
    
    //MARK: Properties
    @Binding var isEditedReminder: Bool
    var reminderObject: ReminderViewModel
    @State var addReminderVM = AddReminderVM()
    @State private var dateChosen = Date()
    
    init(isEditedReminder: Binding<Bool>, reminderObject: ReminderViewModel) {
        self._isEditedReminder = isEditedReminder
        self.reminderObject = reminderObject
    }
    
    // Mark want to return these as separate variables, for easier reading.
    var reminder: String {
        reminderObject.reminder
    }
    
    var uuid: UUID {
        reminderObject.id
    }
    
    // Need to convert the date to a String for display
    var dateString: String {
        // Convert the date to a string
        let dateConversion = convertDateToString(date: reminderObject.date)
        
        // TODO:- Need to come up with some error handling
        var dateString = ""
        if let stringForDate = dateConversion {
            dateString = stringForDate
        }
        return dateString
    }
    
    // Need to convert the type (priority) to a String for display
    var typeString: String {
        //reminderObject.type
        // Convert the type to a string
        let typeConversion = convertTypeToString(type: reminderObject.type)
        
        // TODO:- Need to come up with some error handling
        var typeString = ""
        if let stringForType = typeConversion {
            typeString = stringForType
        }
        return typeString
    }
    
    //MARK: Functions for the Converting
    private func convertTypeToString(type: Int?) -> String? {
        
        guard type != nil else { return nil }
        let typeAsString = addReminderVM.convertIntsToTag(from: type!)
        return typeAsString
    }
    
    private func convertDateToString(date: Date?) -> String? {
        
        guard date != nil else { return nil }
        let dateAsString = Helper().convertDateIntoString(from: date!)
        return dateAsString
    }
    
    // For dismissing a view.
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        Group {
            VStack {
                HStack {
                    Text("Reminder Set - ")
                    TextField(isEditedReminder ? "\(reminder)" : "Enter Reminder", text: self.$addReminderVM.reminder)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                }.padding()
                
                Divider()
                
                if isEditedReminder {
                    Text("Current Priority: \(typeString)").padding()
                }
                // Spacer()
                
                Picker(selection: self.$addReminderVM.tag, label: Text("")) {
                    Text("Urgent").tag("urg")
                    Text("Important").tag("imp")
                    Text("Normal").tag("nrm")
                }.pickerStyle(SegmentedPickerStyle())
                
                
                if isEditedReminder {
                    Text("Current date: \(dateString)").padding()
                }
                
                DatePicker(selection: $dateChosen, in: Date()..., displayedComponents: .date) {
                    Text("")
                }.frame(width: UIWidth - 60, height: UIHeight / 4, alignment: .center)
                    .padding(.bottom, 20)
                
                Button(isEditedReminder ? "Save Changes" : "Add Reminder", action:  {
                    // place reminder
                    let date = self.dateChosen
                    let convertDate = Helper().convertDateFromPickerWithoutTime(for: date)
                    
                    self.addReminderVM.date = convertDate
                    
                    if self.isEditedReminder {
                        self.addReminderVM.id = self.uuid
                        if self.addReminderVM.reminder.isEmpty {
                            self.addReminderVM.reminder = self.reminder
                        }
                        self.addReminderVM.updateReminder()
                        
                    } else {
                        self.addReminderVM.saveReminder()
                        
                    }
                    
                    self.presentationMode.wrappedValue.dismiss()
                    
                }).padding(8)
                    .foregroundColor(Color.white)
                    .background(Color.green)
                    .cornerRadius(10)
                
            }
        }.padding()
            .navigationBarTitle("Edit Reminder", displayMode: .inline)
        
    }
}



//struct EditReminderView_Previews: PreviewProvider {
//    
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//    
//    static var previews: some View {
//        EditReminderView(isEditedReminder: true, reminder: "reminder", typeString: "type", dateString: "date", id: UUID())
//    }
//}
