//
//  ContentView.swift
//  Inspiration App
//
//  Created by Nikita Koniukh on 10/05/2020.
//  Copyright © 2020 Nikita Koniukh. All rights reserved.
//

import SwiftUI

struct SliderMotivationContentView: View {

    let motivations = DataService.instance.getMotivations()

       let currentDate  = CurrentMotivation.instance.getCurrentDate()
       let yestardayDate = CurrentMotivation.instance.getYestardayDate()
       let tomorrowDate = CurrentMotivation.instance.getTomorrowDate()

        let subviews = CurrentMotivation.instance.subviews

 

    @State var currentPageIndex = 1

    var body: some View {


        VStack(alignment: .leading) {
            PageViewController(currentPageIndex: $currentPageIndex, viewControllers: subviews)
                .frame(minHeight: 0, maxHeight: .infinity)

            Group {
                if currentPageIndex == 0 {
                    Text(yestardayDate)
                    .font(.subheadline)
                } else if currentPageIndex == 1 {
                    Text(currentDate)
                    .font(.subheadline)
                } else if currentPageIndex == 2{
                    Text(tomorrowDate)
                    .font(.subheadline)
                }

                Text(motivations[currentPageIndex].motivationDate)
                    .font(.title)
                Text(motivations[currentPageIndex].description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .frame(width: 300, height:100, alignment: .leading)
                    .lineLimit(nil)
            }

            .padding(.leading)
        }
    }
}

#if DEBUG
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        SliderMotivationContentView()
    }
}
#endif
