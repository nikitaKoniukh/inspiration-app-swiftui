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
    var body: some View {
        ZStack {
            Text(motivDat)
                .font(.callout)
                .padding(6)
                .foregroundColor(.white)
        }.background(Color.black)
            .opacity(0.8)
            .cornerRadius(10.0)
            .padding(6)
    }
}

struct Subview: View {

    var imageString: String
    var motivationDate: String


    var body: some View {
        HStack {
            Image(imageString)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .clipped()
                .blur(radius: 5)
                .overlay(ImageOverlay(motivDat: motivationDate), alignment: .bottomTrailing)
        }
    }
}

#if DEBUG
struct Subview_Previews: PreviewProvider {
    static var previews: some View {
        Subview(imageString: "1", motivationDate: "101010")
    }
}
#endif
