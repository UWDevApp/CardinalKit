//
//  List+GroupedStyle.swift
//  TrialX
//
//  Created by Apollo Zhu on 4/6/21.
//  Copyright © 2021 TrialX. All rights reserved.
//

import SwiftUI

extension View {
    func withSomeGroupedListStyle() -> some View {
        Group {
            if #available(iOS 14.0, *) {
                self
                    .listStyle(InsetGroupedListStyle())
            } else {
                self
                    .listStyle(GroupedListStyle())
            }
        }
    }
}
