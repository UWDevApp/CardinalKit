//
//  StudyTableItem.swift
//
//  Created for the CardinalKit Framework.
//  Copyright © 2019 Stanford University. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
import ResearchKit

enum StudyTableItem: Int, CaseIterable {
    // table items
    case survey, trailMakingA, trailMakingB, spatial, speechRecognition, amslerGrid

    var task: ORKOrderedTask {
        switch self {
        case .survey:
            return StudyTasks.survey
        case .trailMakingA:
            return StudyTasks.trailMakingA
        case .trailMakingB:
            return StudyTasks.trailMakingB
        case .spatial:
            return StudyTasks.spatial
        case .speechRecognition:
            return StudyTasks.speechRecognition
        case .amslerGrid:
            return StudyTasks.amslerGrid
        }
    }

    var title: String {
        switch self {
        case .survey:
            return "Patient Survey"
        case .trailMakingA:
            return "Trail Making A"
        case .trailMakingB:
            return "Trail Making B"
        case .spatial:
            return "Spatial Memory"
        case .speechRecognition:
            return "Speech Recognition"
        case .amslerGrid:
            return "Amsler Grid"
        }
    }

    var subtitle: String {
        switch self {
        case .survey:
            return "Survey of basic health information"
        case .trailMakingA:
            return "This activity evaluates your visual activity and task"
        case .trailMakingB:
            return "This activity evaluates your visual activity and task"
        case .spatial:
            return "This activity measures your short term spacial memory"
        case .speechRecognition:
            return "This activity records your speech"
        case .amslerGrid:
            return "This activity helps with detecting problems in your vision"
        }
    }

    var image: Image? {
        switch self {
        case .survey:
            return Image(systemName: "doc.plaintext")
        case .trailMakingA, .trailMakingB:
            if #available(iOS 14, *) {
                return Image(systemName: "point.fill.topleft.down.curvedto.point.fill.bottomright.up")
            } else {
                return Image(systemName: "scribble")
            }
        case .spatial:
            if #available(iOS 14, *) {
                return Image(systemName: "square.grid.3x3.middleright.fill")
            } else {
                return Image(systemName: "circle.grid.3x3")
            }
        case .speechRecognition:
            if #available(iOS 14, *) {
                return Image(systemName: "rectangle.3.offgrid.bubble.left")
            } else {
                return Image(systemName: "mic")
            }
        case .amslerGrid:
            if #available(iOS 14, *) {
                return Image(systemName: "dot.squareshape.split.2x2")
            } else {
                return Image(systemName: "dot.square")
            }
        }
    }
}
