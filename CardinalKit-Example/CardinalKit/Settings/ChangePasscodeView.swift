//
//  ChangePasscodeView.swift
//  TrialX
//
//  Created by Apollo Zhu on 9/11/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI
import ResearchKit

struct ChangePasscodeView: View {
    @State var showPasscode = false

    var body: some View {
        Button("Change Passcode") {
            if ORKPasscodeViewController.isPasscodeStoredInKeychain() {
                self.showPasscode.toggle()
            }
        }
        .sheet(isPresented: $showPasscode) {
            PasscodeVC()
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct ChangePasscodeView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Section {
                ChangePasscodeView()
            }
        }
        .listStyle(GroupedListStyle())
    }
}