//
//  StatisticsView.swift
//  TrialX
//
//  Created by Lucas Wang on 2020-09-13.
//  Copyright © 2020 TrialX. All rights reserved.
//

import SwiftUI
import CareKitUI

struct StatisticsView: View {
    @EnvironmentObject var data: NotificationsAndResults
    let date = DateFormatter.mediumDate.string(from: Date())
    

    let color: Color
    
    /**
     Example data used to generate a stats summary section
     */
//    var trendView: some View {
//        let trend = OCKCartesianChartView(type: .line)
//
//        func updateTrend() {
//            trend.graphView.yMinimum = 0
//            trend.graphView.yMaximum = 10
//            trend.graphView.xMinimum = 0
//            trend.graphView.xMaximum = 7
//        }
//
//        Section(header: Text("Here, you can review your scores and trends")) {
//            trendView
//
//        }
//
//        return self
//    }
    
    var cogTestsView: some View {
        /**
            Upcoming cognitive tests
         */
        Section(header: Text("Cognitive tests").font(.subheadline)) {
            ForEach(self.data.cogTests) { cogTest in
                SimpleTaskView(
                    title: Text(cogTest.testName),
                    detail: Text(cogTest.text)
                ) {
                    cogTest.studyItem.image
                        .resizable()
                        .imageScale(.large)
                        .frame(width: 32, height: 32, alignment: .center)
                        .padding()
                        .foregroundColor(.accentColor)
                }
            }
        }
    }
            
    var otherTestsView: some View {
        /**
            Upcoming other tests
         */
        Section(header: Text("Other tests").font(.subheadline)) {
            ForEach(self.data.otherTests) { otherTest in
                SimpleTaskView(
                    title: Text(otherTest.testName),
                    detail: Text(otherTest.text)
                ) {
                    otherTest.studyItem.image
                        .resizable()
                        .imageScale(.large)
                        .frame(width: 32, height: 32, alignment: .center)
                        .padding()
                        .foregroundColor(.accentColor)
                }
            }
        }
    }
    
    var testsView: some View {
        Group {
            cogTestsView
            Spacer().padding(.bottom)
            otherTestsView
        }
    }
    
    var body: some View {
        PlainList {
            #warning("TODO: Sync chart view test score data")
            //trendView
            testsView
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationBarItems(trailing: Text(date).foregroundColor(color))
    }
    
    
}
