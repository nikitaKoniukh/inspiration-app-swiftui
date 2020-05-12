//
//  ContentView.swift
//  Inspiration App
//
//  Created by Nikita Koniukh on 10/05/2020.
//  Copyright © 2020 Nikita Koniukh. All rights reserved.
//

import SwiftUI

struct SliderMotivationContentView: View {

    @State var subviews = CurrentMotivation.instance.setSubViews()
    @State var currentPageIndex = 0

    var body: some View {
        VStack(alignment: .leading) {
            PageViewController(currentPageIndex: $currentPageIndex, viewControllers: subviews)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#if DEBUG
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        SliderMotivationContentView()
    }
}
#endif
