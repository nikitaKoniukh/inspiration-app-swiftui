//
//  CurrentMotivation.swift
//  Inspiration App
//
//  Created by Nikita Koniukh on 11/05/2020.
//  Copyright © 2020 Nikita Koniukh. All rights reserved.
//

import Foundation
import SwiftUI

struct CurrentMotivation {

    static var instance = CurrentMotivation()

    var dataService = DataService.instance.getMotivations()

    lazy var subviews = [
        UIHostingController(rootView: Subview(imageString: "1", motivationDate: getYestardayDate(), motivatioText: dataService[0].description)),
        UIHostingController(rootView: Subview(imageString: "2", motivationDate: getCurrentDate(), motivatioText: dataService[1].description)),
        UIHostingController(rootView: Subview(imageString: "3", motivationDate: getTomorrowDate(), motivatioText: dataService[2].description)),

    ]

    func getCurrentDate() -> String {
        let todaysDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        let DateInFormat = dateFormatter.string(from: todaysDate as Date)
        return DateInFormat
    }


    func getYestardayDate() -> String {
        let todaysDate = Date.yesterday
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        let DateInFormat = dateFormatter.string(from: todaysDate as Date)
        return DateInFormat
    }

    func getTomorrowDate() -> String {
        let todaysDate = Date.tomorrow
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        let DateInFormat = dateFormatter.string(from: todaysDate as Date)
        return DateInFormat
    }

}

extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
}
