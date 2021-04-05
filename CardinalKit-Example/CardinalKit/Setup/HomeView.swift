//
//  HomeView.swift
//  TrialX
//
//  Created by Apollo Zhu on 9/13/20.
//  Copyright © 2020 TrialX. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var config: CKPropertyReader
    var color: Color {
        return Color(config.readColor(query: "Primary Color"))
    }

    var body: some View {
        TabView {
            NavigationView {
                ZStack {
                    Color(UIColor.systemGroupedBackground)
                        .edgesIgnoringSafeArea(.all)

                    WelcomeNotificationView()
                        .navigationBarTitle("Home")
                }
            }
            .tabItem {
                Image(systemName: "house")
                    .renderingMode(.template)
                Text("Home")
            }
            
            NavigationView {
                ZStack {
                    Color(UIColor.systemGroupedBackground)
                        .edgesIgnoringSafeArea(.all)

                    StatisticsView(color: color)
                        .navigationBarTitle("Statistics")
                }
            }
            .tabItem {
                Image(systemName: "gauge")
                    .renderingMode(.template)
                Text("Statistics")
            }

            ScheduleViewControllerRepresentable()
                .tabItem {
                    Image("tab_schedule").renderingMode(.template)
                    Text("Schedule")
                }

            CareTeamViewControllerRepresentable()
                .tabItem {
                    Image("tab_care").renderingMode(.template)
                    Text("Contact")
                }

            //            ActivitiesView(color: color)
            //                .tabItem {
            //                    Image("tab_activities")
            //                        .renderingMode(.template)
            //                    Text("Testing Activities")
            //                }

            ProfileView()
                .tabItem {
                    Image("tab_profile")
                        .renderingMode(.template)
                    Text("Profile")
                }

            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                        .renderingMode(.template)
                    Text("Settings")
                }
        }
        .accentColor(color)
        .environmentObject(NotificationsAndResults())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(CKPropertyReader(file: "CKConfiguration"))
    }
}
