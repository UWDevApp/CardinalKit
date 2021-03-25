//
//  WebsiteView.swift
//  TrialX
//
//  Created by Apollo Zhu on 9/12/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI

struct WebsiteView: View {
    let site: String

    var body: some View {
        HStack() {
            VStack(alignment: .leading) {
                Text("Visit TrialX Website")
                Text("Learn more about TrialX and the team")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
                .accessibility(addTraits: .isButton)
                .accessibility(value: Text(site))
        }
        .onTapGesture {
            if let url = URL(string: self.site) {
                UIApplication.shared.open(url)
            }
        }
    }
}

struct WebsiteView_Previews: PreviewProvider {
    static var previews: some View {
        WebsiteView(site: "apple.com")
    }
}
