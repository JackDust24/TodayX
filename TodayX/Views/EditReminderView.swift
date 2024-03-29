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
    @State var editCurrentReminder = AddReminderVM()
    @State private var dateChosen = Date()
    // For counting the length of the text field
    @ObservedObject var textFieldManager = TextFieldManager()
    
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
        let typeAsString = editCurrentReminder.convertIntsToTag(from: type!)
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
                    Text("Reminder Set - ").scaledToFill()
                    TextField(isEditedReminder ? "\(reminder)" : "Enter Reminder", text: self.$textFieldManager.userInput)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Spacer()
                    
                    Text("\(textFieldManager.characterCount)/25")
                        .font(.caption)
                        // 3
                        .foregroundColor(
                            textFieldManager.characterCount > 0
                                ? .green
                                : .red)
                        .padding(.trailing)
                    
                }.padding()
                
                Divider()
                
                if isEditedReminder {
                    Text("Current Priority: \(typeString)").padding()
                }
                // Spacer()
                
                Picker(selection: self.$editCurrentReminder.tag, label: Text("")) {
                    Text("Urgent").tag("Urgent")
                    Text("Important").tag("Important")
                    Text("Normal").tag("Normal")
                }.pickerStyle(SegmentedPickerStyle())
                
                
                if isEditedReminder {
                    Text("Current date: \(dateString)").padding()
                }
                
                DatePicker(selection: $dateChosen, in: Date()..., displayedComponents: .date) {
                    Text("")
                }.onAppear() {
                    self.dateChosen = self.reminderObject.date
                }
                .frame(width: UIWidth - 60, height: UIHeight / 4, alignment: .center)
                .padding(.bottom, 20)
                
                Button(isEditedReminder ? "Save Changes" : "Add Reminder", action:  {
                    // place reminder
                    let date = self.dateChosen
                    let convertDate = Helper().convertDateFromPickerWithoutTime(for: date)
                    
                    self.editCurrentReminder.date = convertDate
                    
                    // 1. Check if this is anm EditemendReminder (it will but just acts as extra check.
                    if self.isEditedReminder {
                        // 2. Make the Edited Reminder equal the ID
                        self.editCurrentReminder.id = self.uuid
                        // 3. If nothing hsd changed then it equals the current Input
                        if self.textFieldManager.userInput.isEmpty {
                            
                            self.editCurrentReminder.reminder = self.reminder
                        } else {
                            // Otherwise make it the new one.
                            self.editCurrentReminder.reminder = self.textFieldManager.userInput
                        }
                        
                        if self.editCurrentReminder.tag == "" {
                            self.editCurrentReminder.tag = self.typeString
                        }
                        
                        self.editCurrentReminder.updateReminder()
                        
                    } else {
                        self.editCurrentReminder.saveReminder()
                        
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

struct EditReminderView_Previews: PreviewProvider {
    static var previews: some View {
        EditReminderView(isEditedReminder: .constant(true), reminderObject: ReminderViewModel(reminder: Reminders()))
    }
}
