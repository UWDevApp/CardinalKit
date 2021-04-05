//
//  NotificationBubble.swift
//  TrialX
//
//  Created by Lucas Wang on 2020-09-12.
//  Copyright © 2020 TrialX. All rights reserved.
//

import SwiftUI

struct NotificationBubble: View {
    @EnvironmentObject var data: NotificationsAndResults
    @Binding var showingPopup: Bool
    @Binding var showingTestDetail: Bool
    @Binding var currTestIndex: Int
    let notification: Notification
    let backGroundColor: Color
    let textColor: Color
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(notification.testName)
                    .foregroundColor(textColor)
                    .font(.title)
                    .fontWeight(.bold)
                Text(notification.text)
                    .foregroundColor(textColor)
            }

            Spacer()

            if notification.action {
                Button("Take Test") {
                    withAnimation {
                        self.currTestIndex = self.data.getTestIndex(testName: self.notification.testName)
                        self.showingTestDetail = true
                    }
                }
                .foregroundColor(.black)
                .padding(10)
                .background(Color.white)
                .cornerRadius(8)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(self.backGroundColor)
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

//struct NotificationBubble_Previews: PreviewProvider {
//    static var previews: some View {
//        NotificationBubble()
//    }
//}
