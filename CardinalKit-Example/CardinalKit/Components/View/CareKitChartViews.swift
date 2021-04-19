//
//  CareKitChartViews.swift
//  TrialX
//
//  Created by Vicky Xiang on 4/7/21.
//  Copyright © 2021 TrialX. All rights reserved.
//

import SwiftUI
import CareKit
import CareKitUI
import CareKitStore
import UIKit

struct CareKitChartViews: UIViewControllerRepresentable {
    let weekOfDate: Date
    //let configurations: [OCKDataSeriesConfiguration]
    func makeUIViewController(context: Context) -> UIViewController {
        return OCKChartViewController(
            viewSynchronizer: OCKCartesianChartViewSynchronizer.init(plotType: .line, selectedDate: Date()),
            weekOfDate: weekOfDate,
            configurations: [OCKDataSeriesConfiguration(
                taskID: "exampleScore",
                legendTitle: "Score Overview",
                gradientStartColor: .lightGray,
                gradientEndColor: .green,
                markerSize: 10,
                eventAggregator: OCKEventAggregator.countOutcomeValues)],
            storeManager: CKCareKitManager.shared.synchronizedStoreManager)
    }
    

    func updateUIViewController(_ uiViewController: UIViewController,
                                context: Context) {
        // nothing to do
    }
}


