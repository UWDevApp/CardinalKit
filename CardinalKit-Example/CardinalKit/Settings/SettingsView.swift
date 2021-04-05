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

    var footer: some View {
        Text(config.read(query: "Copyright"))
            .padding(.top)
            .frame(maxWidth: .infinity)
    }

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

            Section(header: Text("App \(appVersion.map { "version v\($0)" } ?? "")")) {
                WebsiteView(site: config.read(query: "Website"))
                EmailView(title: "Contact Developers",
                          email: config.read(query: "Email"))
            }

            Section(footer: footer) {
                WithdrawView()
                    .frame(maxWidth: .infinity)
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
