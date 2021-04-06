//
//  SettingsView.swift
//  TrialX
//
//  Created by Apollo Zhu on 3/24/21.
//  Copyright © 2021 TrialX. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var config: CKPropertyReader

    var appVersion: String? {
        return Bundle.main
            .infoDictionary?["CFBundleShortVersionString"] as? String
    }

    @ObservedObject
    var data = NotificationsAndResults.shared

    #warning("TODO: implement push notification instead")
    var notificationToggle: some View {
        Toggle("Push Notifications",
               isOn: $data.shouldSeeDoctor)
    }

    var header: some View {
        Text("App \(appVersion.map { "version v\($0)" } ?? "")")
    }

    var footer: some View {
        Text(config.read(query: "Copyright"))
            .padding(.top)
            .frame(maxWidth: .infinity)
    }


    var list: some View {
        List {
            Section(header: Text("General")) {
                if #available(iOS 14.0, *) {
                    notificationToggle
                        .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                } else {
                    notificationToggle
                }
                ChangePasscodeView()
            }

            Section(header: header, footer: footer) {
                WebsiteView(site: config.read(query: "Website"),
                            title: "Visit TrialX Website",
                            description: "Learn more about TrialX",
                            icon: Image(systemName: "globe"))
                WebsiteView(site: "https://udallcenter.stanford.edu/about/center-researchers/",
                            title: "Pacific Udall Center",
                            description: "Excellence for Parkinson's Research",
                            icon: SFSymbol(iOS14Name: "stethoscope",
                                           iOS13Name: "h.square"))
                WebsiteView(site: "https://uwapp.dev/",
                            title: "Mobile Development Club",
                            description: "RSO at University of Washington",
                            icon: Image(systemName: "hammer"))

                NavigationLink("Acknowledgments",
                               destination: AcknowledgementsView())

                // EmailView(title: "Contact Developers",
                //           email: config.read(query: "Email"))
            }
        }
        .navigationBarItems(trailing: CurrentDate())
        .navigationBarTitle("Settings")
    }

    var body: some View {
        NavigationView {
            if #available(iOS 14.0, *) {
                list
                    .listStyle(InsetGroupedListStyle())
            } else {
                list
                    .listStyle(GroupedListStyle())
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(CKConfig.shared)
    }
}
