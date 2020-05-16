//
//  NotificationSettings.swift
//  Inspiration App
//
//  Created by Nikita Koniukh on 16/05/2020.
//  Copyright © 2020 Nikita Koniukh. All rights reserved.
//

import SwiftUI

struct NotificationSettings: View {
    @Binding var showingModal:Bool
    @State private var selectedTime = Date()
    @State private var showingAlert = false
    @State private var permisionIsGaranted = false

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }

    var body: some View {
        VStack (alignment: .center) {
            Text("Выбери удобное для тебя время для получения уведомлений")
                .font(.largeTitle)
                .padding()
                .multilineTextAlignment(.center)

            DatePicker(selection: $selectedTime, in: Date()..., displayedComponents: .hourAndMinute) {
                Text("")
            }.padding(30)

            Button(action: {
                self.showingModal = false
                self.checkNotificationsPermissions()
            }) {
                if permisionIsGaranted {
                    Text("Выбрать: \(selectedTime, formatter: dateFormatter)")
                        .font(.title)
                }
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Important message"), message: Text("Wear sunscreen"), dismissButton: .default(Text("Got it!"), action: {
                    self.showingModal = false
                }))
            }
        }.onAppear(perform: checkNotificationsPermissions)

    }

    private func checkNotificationsPermissions() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                self.setLocalNotification()
                self.permisionIsGaranted = true
            } else if let error = error {
                print(error.localizedDescription)
            } else {
                print("no")
                self.permisionIsGaranted = false
                self.showingAlert = true

            }
        }
    }

    private func setLocalNotification() {

        let components = Calendar.current.dateComponents([.hour, .minute], from: self.selectedTime)
        let hourSet = components.hour ?? 0
        let minuteSet = components.minute ?? 0

        let center = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent()
        content.title = "Вставай, ленивая жопа!"
        content.body = "Открывай поскорее и заряжайся на целый день!"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default

        var dateComponents = DateComponents()
        dateComponents.hour = hourSet
        dateComponents.minute = minuteSet
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
}
