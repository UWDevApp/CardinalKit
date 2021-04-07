//
//  SpecialThanksView.swift
//  TrialX
//
//  Created by Apollo Zhu on 4/6/21.
//  Copyright © 2021 TrialX. All rights reserved.
//

import SwiftUI

struct SpecialThanksView: View {
    var body: some View {
        List {

            WebsiteView(
                site: "https://cardinalkit.org/blog/2020/09/25/cardinalkit-buildathon",
                title: "CardinalKit Buildathon 2020",
                description: "Where our journey originated.",
                icon: Image(systemName: "flag")
            )
            WebsiteView(
                site: "https://cloud.google.com/covid19",
                title: "Google",
                description: "Sponsor of COVID-19 Hackathon Fund.",
                icon: Image(systemName: "dollarsign.circle")
            )
            WebsiteView(
                site: "https://www.linkedin.com/in/gladys-wang-4b14841ba/",
                title: "Gladys Wang",
                description: "Designer of the app icon.",
                icon: SFSymbol(iOS14Name: "paintpalette",
                               iOS13Name: "paintbrush")
            )
        }
        .withSomeGroupedListStyle()
        .navigationBarTitle("Special Thanks")
    }
}

struct SpecialThanksView_Previews: PreviewProvider {
    static var previews: some View {
        SpecialThanksView()
    }
}
