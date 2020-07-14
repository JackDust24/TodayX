//
//  AddEditReminderView.swift
//  TodayX
//
//  Created by JasonMac on 3/7/2563 BE.
//  Copyright © 2563 Jason Whittaker. All rights reserved.
//

import SwiftUI

struct EditReminderView: View {
    
//    @Binding var isPresented: Bool
//    @ObservedObject var reminderListVM: ReminderListVM

    @Binding var isEditedReminder: Bool
    var reminderObject: ReminderViewModel
    
//    init() {
//        print("Init ReminderListVM")
//        self.reminderListVM = ReminderListVM()
//    }
//
    init(isEditedReminder: Binding<Bool>, reminderObject: ReminderViewModel) {
        self._isEditedReminder = isEditedReminder
        self.reminderObject = reminderObject
//        self.isPresented = isPresented
    }
    
    @State var addReminderVM = AddReminderVM()
    @State private var dateChosen = Date()
    
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
    
    func convertDateToString(date: Date?) -> String? {
        
        guard date != nil else { return nil }
        let dateAsString = Helper().convertDateIntoString(from: date!)
        return dateAsString
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
    
    func convertTypeToString(type: Int?) -> String? {
        
        guard type != nil else { return nil }
        let typeAsString = addReminderVM.convertIntsToTag(from: type!)
        return typeAsString
    }
    
        // For dismissing a view.
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
       // NavigationView {
//            AddEditReminderView(isEditedReminder: isEditedReminder, reminder: reminder, typeString: "typString", dateString: "dateString", id: uuid)
                    Group {
                        
                        VStack {
                            
                            HStack {
                                
                                Text("Reminder Set - ")
                                TextField(isEditedReminder ? "\(reminder)" : "Enter Reminder", text: self.$addReminderVM.reminder)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                     
                            }.padding()
                            
                            Divider()
                           // Spacer()

                            if isEditedReminder {
                                Text("Current Priority: \(typeString)").padding()
                            }
                           // Spacer()

                            Picker(selection: self.$addReminderVM.tag, label: Text("")) {
                                Text("Urgent").tag("urg")
                                Text("Important").tag("imp")
                                Text("Normal").tag("nrm")
                            }.pickerStyle(SegmentedPickerStyle())
                          
                           // Divider()
                            
                            if isEditedReminder {
                                Text("Current date: \(dateString)").padding()
                            }
                                            
//                            Text("Select a date").padding()
                            
                            DatePicker(selection: $dateChosen, in: Date()..., displayedComponents: .date) {
                                Text("")
                                }.frame(width: UIWidth - 60, height: UIHeight / 4, alignment: .center)
                                .padding(.bottom, 20)
                            
                            Button(isEditedReminder ? "Save Changes" : "Add Reminder", action:  {
                                // place reminder
                                let date = self.dateChosen
                                let convertDate = Helper().convertDateFromPickerWithoutTime(for: date)
                                print(convertDate)
                                                    
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
            //                    self.isEditedReminder = false
                                
                                self.presentationMode.wrappedValue.dismiss()
                                
                            }).padding(8)
                                .foregroundColor(Color.white)
                                .background(Color.green)
                                .cornerRadius(10)
                            
                            
                     //   }
                           // Spacer()
                    }.onDisappear(perform: {
                        print("Dismiss Screen")
                        
            //            ReminderListVM.fetchAllReminders()

                    })
//                            .offset(y: -60)
            
            }.padding()
            .navigationBarTitle("Edit Reminder", displayMode: .inline)
//        .navigationBarHidden(true)
         
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
    
        // For dismissing a view.
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
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
//                    self.isEditedReminder = false
                    
                    self.presentationMode.wrappedValue.dismiss()
                    
                }).padding(8)
                    .foregroundColor(Color.white)
                    .background(Color.green)
                    .cornerRadius(10)
                
                
            }
        }.onDisappear(perform: {
            print("Dismiss Screen")
            
//            ReminderListVM.fetchAllReminders()

        })
    }
}

struct AddEditReminderView_Previews: PreviewProvider {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    static var previews: some View {
        AddEditReminderView(isEditedReminder: true, reminder: "reminder", typeString: "type", dateString: "date", id: UUID())
    }
}
