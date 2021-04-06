//
//  ProfileView.swift
//  TrialX
//
//  Created by Apollo Zhu on 9/11/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI
import HealthKit
import ResearchKit
import Firebase
import EFStorageCore
import EFStorageKeychainAccess

extension HKBiologicalSex: CustomStringConvertible {
    public var description: String {
        switch self {
        case .female: return "Female"
        case .male: return "Male"
        case .notSet: return "Unknown"
        case .other: return "Other"
        @unknown default:
            return "Other/Unknown"
        }
    }
}

struct ProfileView: View {
    @EnvironmentObject var config: CKPropertyReader

    @State
    var isEditingBasicInfo: Bool = false
    @ObservedObject
    var studyUser: CKStudyUser = .shared

    @State
    var needsHealthRecordsAccess = false
    @State
    var needsHealthKitAccess = false

    let store = HKHealthStore()

    var name: String {
        studyUser.currentUser?.displayName
            ?? studyUser.currentUser?.uid
            ?? "Unknown"
    }

    var readTypes: Set<HKObjectType> = [
        HKCharacteristicType.characteristicType(forIdentifier: .biologicalSex)!,
        HKCharacteristicType.characteristicType(forIdentifier: .dateOfBirth)!,
    ]

    var basicInfoSection: some View {
        Section(header: HStack {
            Text("Basic Information")
            Spacer()
            Button(action: {
                isEditingBasicInfo = true
            }, label: {
                if #available(iOS 14.0, *) {
                    Label {
                        Text("Edit")
                            .fontWeight(.bold)
                    } icon: {
                        Text(Image(systemName: "square.and.pencil"))
                            .fontWeight(.bold)
                    }
                } else {
                    Text("Edit")
                        .fontWeight(.bold)
                }
            })
        }) {
            HStack {
                Text("Name")
                Spacer()
                Text(name)
                    .foregroundColor(.secondary)
            }
            HStack {
                Text("Date of Birth")
                Spacer()
                Text(studyUser.dateOfBirth.flatMap {
                    DateFormatter.mediumDate.string(from: $0)
                } ?? "Unknown")
                .foregroundColor(.secondary)
            }
            HStack {
                Text("Sex Assigned at Birth")
                Spacer()
                Text(studyUser.sex.description)
                    .foregroundColor(.secondary)
            }
            HStack {
                Text("Handedness")
                Spacer()
                Text(studyUser.handedness ?? "Unknown")
                    .foregroundColor(.secondary)
            }
            HStack {
                Text("Ethnicity")
                Spacer()
                Text(studyUser.ethnicity ?? "Unknown")
                    .foregroundColor(.secondary)
            }
            HStack {
                Text("Education")
                Spacer()
                Text(studyUser.education ?? "Unknown")
                    .foregroundColor(.secondary)
            }
            HStack {
                Text("Postal Code")
                Spacer()
                Text(studyUser.zipCode ?? "Unknown")
                    .foregroundColor(.secondary)
            }
        }
    }

    var clinicalInfoSection: some View {
        Section(header: Text("Clinical Information"),
                footer: Group {
                    if  HKHealthStore.isHealthDataAvailable() {
                        Text("To manage which health data categories are accessible by TrialX, go to the system Health app.")
                    } else {
                        EmptyView()
                    }
                }
        ) {
            HStack {
                ConsentDocumentButton(title: "Consent Document")
                Spacer()
                if #available(iOS 14.0, *) {
                    Label("Signed", systemImage: "checkmark.square.fill")
                } else {
                    Text("Signed")
                }
            }
            if needsHealthRecordsAccess {
                Button("Grant Electronic Health Record (EHR) Access") {
                    CKHealthRecordsManager.shared.getAuth { success, _ in
                        if success {
                            updateHealthRecordsAccessStatus()
                            CKHealthRecordsManager.shared.upload()
                        }
                    }
                }
            }
            if needsHealthKitAccess {
                Button("Grant Health Data Access") {
                    store.requestAuthorization(toShare: nil, read: readTypes) { success, error in
                        if success {
                            updateHealthKitAccessStatus()
                        }
                    }
                }
            }
        }
    }

    var list: some View {
        List {
            basicInfoSection

            clinicalInfoSection

            WithdrawView()
                .frame(maxWidth: .infinity)
        }
        .navigationBarItems(trailing: CurrentDate())
        .navigationBarTitle("Profile")
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
        .sheet(isPresented: $isEditingBasicInfo) {
            TaskVC(tasks: StudyTasks.basicInfoSurvey, onComplete: { result in
                guard case let .success(taskResult) = result else { return }
                updateBasicInfo(with: taskResult)
            })
            .edgesIgnoringSafeArea(.all)
        }
        .onAppear {
            if HKHealthStore.isHealthDataAvailable() {
                updateHealthKitAccessStatus()
                updateHealthRecordsAccessStatus()
            }
        }
    }

    func updateHealthKitAccessStatus() {
        store.getRequestStatusForAuthorization(toShare: [], read: readTypes) { status, error in
            withAnimation {
                switch status {
                case .shouldRequest: needsHealthKitAccess = true
                case .unknown: print(error ?? CKError.unknownError)
                case .unnecessary: needsHealthKitAccess = false
                @unknown default: needsHealthKitAccess = false
                }
            }
        }
    }

    func updateHealthRecordsAccessStatus() {
        store.getRequestStatusForAuthorization(toShare: [], read: CKHealthRecordsManager.types) { status, error in
            withAnimation {
                switch status {
                case .shouldRequest: needsHealthRecordsAccess = true
                case .unknown: print(error ?? CKError.unknownError)
                case .unnecessary: needsHealthRecordsAccess = false
                @unknown default: needsHealthRecordsAccess = false
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(CKConfig.shared)
    }
}
