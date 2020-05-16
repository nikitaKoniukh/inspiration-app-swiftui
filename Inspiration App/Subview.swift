//
//  Subview.swift
//  Inspiration App
//
//  Created by Nikita Koniukh on 10/05/2020.
//  Copyright © 2020 Nikita Koniukh. All rights reserved.
//

import SwiftUI

struct ImageOverlay: View {

    var motivDat: String
    var motivText: String

    var body: some View {
        ZStack {

            VStack {
                Spacer()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 80)
                Text(motivDat)
                    .font(.custom("Avenir-Next", size: 60))
                    .bold()
                    .padding(6)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                Spacer()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 120)

                Text(motivText)
                    .font(.custom("Avenir-Next", size: 35))
                    .bold()
                    .padding(6)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            }
        }
        
    }
}

struct Subview: View {

    var imageString: String
    var motivationDate: String
    var motivatioText: String

    var body: some View {
        HStack {
            Image(imageString)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .clipped()
                .overlay(ImageOverlay(motivDat: motivationDate, motivText: motivatioText), alignment: .top)
            .gesture(TapGesture(count: 2).onEnded {
                self.shareButton(textToShare: self.motivatioText + "\n---Motivations---" + "\nwww.Сдесь будет ссылка на приложение")
            })
        }
        .edgesIgnoringSafeArea(.all)
    }

    func shareButton(textToShare: String) {
        let vc = UIActivityViewController(activityItems: [textToShare], applicationActivities: [])
        vc.excludedActivityTypes =  [
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.mail,
            UIActivity.ActivityType.message
        ]
        UIApplication.shared.windows.first?.rootViewController?.present(vc, animated: true, completion: nil)
    }
}

#if DEBUG
struct Subview_Previews: PreviewProvider {
    static var previews: some View {
        Subview(imageString: "1", motivationDate: "101010", motivatioText: "kjdsnfkjsdfsdfjosdjf")
    }
}
#endif
