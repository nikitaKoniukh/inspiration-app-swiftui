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



    var s: [UIHostingController<Subview>]? {
        get {
            return UserDefaults.standard.object(forKey: "savedMotivations") as? [UIHostingController<Subview>]
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "savedMotivations")
        }
    }

    var motivationsThatWereShawnId: [Int]? {
        get {
            UserDefaults.standard.array(forKey: "savedMotivationsId") as? [Int]
        } set {
            UserDefaults.standard.set(newValue, forKey: "savedMotivationsId")
        }

    }

   var getAllObjects: [Motivation] {
    let defaultObject = Motivation(description: dataService[0].description, motivationDate: getCurrentDate(), id: 0)
         if let objects = UserDefaults.standard.value(forKey: "user_objects") as? Data {
            let decoder = JSONDecoder()
            if let objectsDecoded = try? decoder.decode(Array.self, from: objects) as [Motivation] {
               return objectsDecoded
            } else {
               return [defaultObject]
            }
         } else {
            return [defaultObject]
         }
      }

    func saveAllObjects(allObjects: [Motivation]) {
         let encoder = JSONEncoder()
         if let encoded = try? encoder.encode(allObjects){
            UserDefaults.standard.set(encoded, forKey: "user_objects")
         }
    }


    mutating func setSubViews() -> [UIHostingController<Subview>]{

        var motivations = [Motivation]()
        motivations = getAllObjects



        // check if array contains default object with id 0, if yes remove
        // result will be true just for the first run
        if motivations.contains(where: { $0.id == 0}) {
            motivations.removeAll()
        }

         //check date
        let lastMotivation = motivations.last
        if lastMotivation?.motivationDate == getCurrentDate() {
            var subviews = [UIHostingController<Subview>]()
            for item in motivations {
                subviews.append(UIHostingController(rootView: Subview(imageString: "5", motivationDate: getCurrentDate(), motivatioText: item.description)))
            }
            return subviews
        }


        //save new motivation
        let id = getCurrentMotivationId()
        let newMotivation = Motivation(description: dataService[id].description, motivationDate: getCurrentDate(), id: id)
        motivations.append(newMotivation)
        saveAllObjects(allObjects: motivations)

        // add subview
        var subviews = [UIHostingController<Subview>]()
        for item in motivations {
            //random image
            let imageString = String(Int.random(in: 1...10))

            subviews.append(UIHostingController(rootView: Subview(imageString: imageString, motivationDate: getCurrentDate(), motivatioText: item.description)))
        }
        return subviews
    }

    mutating func getCurrentMotivationId() -> Int{
        var lastMotivationId: Int

        if motivationsThatWereShawnId == nil {
            motivationsThatWereShawnId = [Int]()
            lastMotivationId = 1
            motivationsThatWereShawnId?.append(1)
            return lastMotivationId
        } else {
            lastMotivationId = motivationsThatWereShawnId?.last ?? 0
            lastMotivationId += 1
            motivationsThatWereShawnId?.append(lastMotivationId)
            return lastMotivationId
        }
    }



    func getCurrentDate() -> String {
        let todaysDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MMM \nEEEE"
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
