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
    

    var motivationsThatWereShawnId: [Int]? {
        get {
            UserDefaults.standard.array(forKey: "savedMotivationsId") as? [Int]
        } set {
            UserDefaults.standard.set(newValue, forKey: "savedMotivationsId")
        }
    }

    var getAllMotivations: [Motivation] {
        let defaultObject = Motivation(description: "Следующая мотвация будет доступна завтра", motivationDate: "", id: 0)
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

    func saveAllMotivations(allObjects: [Motivation]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(allObjects){
            UserDefaults.standard.set(encoded, forKey: "user_objects")
        }
    }


    mutating func setSubViews() -> [UIHostingController<Subview>]{

        var motivations = [Motivation]()
        motivations = getAllMotivations

        //check date
        if motivations.contains(where: { $0.motivationDate == getCurrentDate() }) {
            var subviews = [UIHostingController<Subview>]()
            for item in motivations {
                //random image
                let imageString = String(Int.random(in: 1...18))
                subviews.append(UIHostingController(rootView: Subview(imageString: imageString, motivationDate: item.motivationDate, motivatioText: item.description)))
            }
            return subviews
        }

        //save new motivation
        let id = getCurrentMotivationId()
        let newMotivation = Motivation(description: dataService[id].description, motivationDate: getCurrentDate(), id: id)
        let defaultObject = Motivation(description: "Следующая мотвация будет доступна завтра", motivationDate: "", id: 10000)

        motivations.remove(at: motivations.count - 1)
        motivations.append(newMotivation)
        motivations.append(defaultObject)

        saveAllMotivations(allObjects: motivations)

        // add subview
        var subviews = [UIHostingController<Subview>]()
        for item in motivations {
            //random image
            let imageString = String(Int.random(in: 1...18))

            subviews.append(UIHostingController(rootView: Subview(imageString: imageString, motivationDate: item.motivationDate, motivatioText: item.description)))
        }
        return subviews
    }

    mutating func getCurrentMotivationId() -> Int{
        var lastMotivationId: Int

        if motivationsThatWereShawnId == nil {
            motivationsThatWereShawnId = [Int]()
            lastMotivationId = 0
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
