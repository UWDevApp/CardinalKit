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

    @State
    var isPushNotificationEnabled = false

    #warning("TODO: implement push notification")
    var notificationToggle: some View {
        Toggle("Push Notifications",
               isOn: $isPushNotificationEnabled)
    }

    var body: some View {
        NavigationView {
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
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(CKConfig.shared)
    }
}
