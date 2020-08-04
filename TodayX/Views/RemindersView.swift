//
//  RemindersView.swift
//  TodayX
//
//  Created by JasonMac on 16/6/2563 BE.
//  Copyright © 2563 Jason Whittaker. All rights reserved.
//

import SwiftUI

struct RemindersView: View {
    
    // MARK: Properties
    @ObservedObject var reminderListVM: ReminderListVM
    // isPresented is for the popup for addind a new reminder
    @State private var isPresented: Bool = false
    // isEditable is for editing the reminder.
    @State private var isEditable: Bool = true
    
    // For showing the date in a viewable way for the user
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
    init() {
        self.reminderListVM = ReminderListVM()
//        UITableView.appearance().backgroundColor = UIColor(named: kVeryLightBlueColour)
    }
    
    //TODO:- Move to the View Model
    // Delete the row
    private func delete(at offsets: IndexSet) {
        offsets.forEach { index in
            let reminderVM = self.reminderListVM.reminders[index]
            self.reminderListVM.deleteReminder(reminderVM)
        }
    }
    
    // Reload the view
    private func reload(at offsets: IndexSet) {
        offsets.forEach { index in
            let reminderVM = self.reminderListVM.reminders[index]
            self.reminderListVM.deleteReminder(reminderVM)
        }
    }
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(self.reminderListVM.reminders, id: \.reminder) { reminder in
                    NavigationLink(destination: EditReminderView(isEditedReminder: self.$isEditable, reminderObject: reminder))  {
                        HStack {
                            
                            Image(self.reminderListVM.getImagesForTheType(for: reminder.type))
                                .resizable()
                                .frame(width: 60, height: 60)
                                .cornerRadius(10)
                                .clipShape(Circle())
                                .saturation(1.5)
                                .blur(radius: 0.3)
                            VStack {
                                Text(reminder.reminder)
                                    .font(.headline)
                                    .padding([.leading], 10)
                                    .padding(.bottom, 5)
                                    .frame(width: 200, height: 30, alignment: .leading)
                                
                                Text("\(reminder.date, formatter: self.dateFormatter)")
                                    .font(.subheadline)
                                    .padding([.leading], 10)
                                    .frame(width: 260, height: 30, alignment: .center)

                            }
                            
                        }
                    }
                    
                }.onDelete(perform: delete)
                    .listRowBackground(Color(kVeryLightBlueColour).opacity(0.5))
                
            }.onAppear(perform: {
                self.reminderListVM.fetchAllReminders()
            })
                .sheet(isPresented: $isPresented, onDismiss: {
                    // This is the sheet for adding new reminders and onDismiss we want to be able to reload again.
                    self.reminderListVM.fetchAllReminders()
                }, content: {
                    AddReminderView(isPresented: self.$isPresented)
                })
                .navigationBarTitle("Reminders", displayMode: .inline)
                .navigationBarItems(trailing:
                    Button(action: { self.isPresented = true }, label: {Image(systemName: "plus")})
            )
            
        }
    }
    
}


struct RemindersView_Previews: PreviewProvider {
    static var previews: some View {
        RemindersView()
    }
}

