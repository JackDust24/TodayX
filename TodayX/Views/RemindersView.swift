//
//  RemindersView.swift
//  TodayX
//
//  Created by JasonMac on 16/6/2563 BE.
//  Copyright © 2563 Jason Whittaker. All rights reserved.
//

import SwiftUI

struct RemindersView: View {
    
    @ObservedObject var reminderListVM: ReminderListVM
    @State private var isPresented: Bool = false
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
      
      init() {
          self.reminderListVM = ReminderListVM()
      }
      
      private func delete(at offsets: IndexSet) {
          offsets.forEach { index in
              let reminderVM = self.reminderListVM.reminders[index]
              self.reminderListVM.deleteReminder(reminderVM)
          }
      }
      
    private func getImagesForTheType(for type: Int) -> String {
        if type == 0 {
            return "urg"
        } else if type == 1 {
            return "imp"
        } else {
            return "nrm"
        }
    }
    
    
    var body: some View {
         
        NavigationView {
            List {
                ForEach(self.reminderListVM.reminders, id: \.reminder) { reminder in
                    HStack {
                       
                        Image(self.getImagesForTheType(for: reminder.type))
                          .resizable()
                          .frame(width: 100, height: 100)
                          .cornerRadius(10)
                                          
                        Text(reminder.reminder)
                          .font(.subheadline)
                          .padding([.leading], 10)
                        
//                         Text(reminder.date)
                        Text("\(reminder.date, formatter: self.dateFormatter)")
                        //                          .font(.med)
                         .padding([.leading], 5)
                    }
                }.onDelete(perform: delete)
            }
            .sheet(isPresented: $isPresented, onDismiss: {
                       print("ONDISMISS")
                       self.reminderListVM.fetchAllReminders()
                   }, content: {
                       AddReminderView(isPresented: self.$isPresented)
                   })
            .navigationBarTitle("Reminders")
            .navigationBarItems(trailing: Button("Add New Reminder") {
                self.isPresented = true
            })
        }
    }
    
//    private let imageType = self.reminderListVM.getImagesForType
}


struct RemindersView_Previews: PreviewProvider {
    static var previews: some View {
        RemindersView()
    }
}

