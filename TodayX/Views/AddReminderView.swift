//
//  AddReminderView.swift
//  TodayX
//
//  Created by JasonMac on 16/6/2563 BE.
//  Copyright © 2563 Jason Whittaker. All rights reserved.
//

import SwiftUI
import Combine

struct AddReminderView: View {
    
    //MARK: Properties
    @Binding var isPresented: Bool // Binded so the master view knows when dismissed.
    @State var addReminderVM = AddReminderVM()
    @State private var dateChosen = Date()
        
    // So we can control the amount the user adds to the text field
    @ObservedObject var textFieldManager = TextFieldManager()
    
    // For dismissing a view.
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        Group {
            VStack {
                
                Text("Set Reminder").padding()
                
                HStack {
                    TextField("Enter Reminder", text: self.$textFieldManager.userInput, onEditingChanged: onEditingChanged(_:), onCommit: onCommit).padding()
                    
                    Spacer()
                    
                    Text("\(textFieldManager.characterCount)/25")
                        .font(.caption)
                        // 3
                        .foregroundColor(
                            textFieldManager.characterCount > 0
                                ? .green
                                : .red)
                        .padding(.trailing)
                }
                
                Divider()
                
                Text("Set Priority").padding()
                Picker(selection: self.$addReminderVM.tag, label: Text("")) {
                    Text("Urgent").tag("Urgent")
                    Text("Important").tag("Important")
                    Text("Normal").tag("Normal")
                }.pickerStyle(SegmentedPickerStyle())
                    .padding()
                
                Text("Select a date").padding()
                
                DatePicker(selection: $dateChosen, in: Date()..., displayedComponents: .date) {
                    Text("")
                }.frame(width: UIWidth - 60, height: UIHeight / 4, alignment: .center)
                
                Button("Add Reminder", action:  {
                    // place reminder
                    let date = self.dateChosen
                    let convertDate = Helper().convertDateFromPickerWithoutTime(for: date)
                    self.addReminderVM.reminder = self.textFieldManager.userInput
                    self.addReminderVM.date = convertDate
                    self.addReminderVM.saveReminder()
                    self.isPresented = false
                    
                    self.presentationMode.wrappedValue.dismiss()
                    
                }).padding(8)
                    .foregroundColor(Color.white)
                    .background(
                        textFieldManager.isReminderValid()
                            ? Color.green
                            : Color.gray)
                    .opacity(
                        textFieldManager.isReminderValid()
                            ? 1.0
                            : 0.4)
                    .cornerRadius(10)
                    .disabled(!textFieldManager.isReminderValid())
                
            }.padding()
                .navigationBarTitle("Add Reminder", displayMode: .inline)
        }
    }
    
    func onCommit() {
        print("commit")
    }
    
    func onEditingChanged(_ changed: Bool) {
        print("Changed - \(changed)")
    }
}

struct AddReminderView_Previews: PreviewProvider {
    static var previews: some View {
        AddReminderView(isPresented: .constant(false))
    }
}
