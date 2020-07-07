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
                                Text("Change the date. Current date: TBD").padding()
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
