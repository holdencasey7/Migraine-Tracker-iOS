// Constants.swift
// Migraine Tracker
// Created by Holden Casey on 1/5/25.

import Foundation
import SwiftUI

enum Constants {
    private static let baseScreenWidth: CGFloat = 440 // iPhone 16 Pro Max width
    private static let baseScreenHeight: CGFloat = 956 // iPhone 16 Pro Max height

    private static var screenWidthRatio: CGFloat {
        UIScreen.main.bounds.width / baseScreenWidth
    }

    private static var screenHeightRatio: CGFloat {
        UIScreen.main.bounds.height / baseScreenHeight
    }

    private static func scaledValue(width value: CGFloat) -> CGFloat {
//        print(UIScreen.main.bounds.width)
//        print(UIScreen.main.bounds.height)
        return value * screenWidthRatio
    }

    private static func scaledValue(height value: CGFloat) -> CGFloat {
        return value * screenHeightRatio
    }
    
    // Home View
    static let leadingTriggerTreatmentFontSize: CGFloat = 21

    // Subtitle
    static let subtitleKerning: CGFloat = 3
    static let subtitleFontSize: CGFloat = 19
    
    // Body
    static let bodyFontSize: CGFloat = 15
    
    // Header
    static let headerFontSize: CGFloat = 24

    // Intensity
    static let minIntensity: Int = 1
    static let maxIntensity: Int = 5
    static let intensityFractionFontSize: CGFloat = 25

    // Weather View
    static let weatherViewRoundedRectangleCornerRadius: CGFloat = scaledValue(width: 30)
    static let weatherViewRoundedRectanlgeBorderWidth: CGFloat = scaledValue(width: 1)
    static let weatherViewInnerHStackSpacing: CGFloat = scaledValue(width: 1)
    static let weatherViewOuterHStackSpacing: CGFloat = scaledValue(width: 35)

    // Generic Views
    static let genericTileViewTitleFontSize: CGFloat = scaledValue(height: 14)
    static let genericTileViewFrameMaxWidth: CGFloat = scaledValue(width: 100)
    static let genericTileViewFrameMaxHeight: CGFloat = scaledValue(height: 100)
    static let genericRowViewTitleFontSize: CGFloat = scaledValue(height: 19)
    static let genericRowViewFrameMaxWidth: CGFloat = scaledValue(width: 45)
    static let genericRowViewFrameMaxHeight: CGFloat = scaledValue(height: 30)
    static let genericListViewVStackSpacing: CGFloat = scaledValue(height: 5)
    static let genericIconlessRowViewTitleFontSize: CGFloat = scaledValue(height: 19)
    static let genericIconlessHorizontalScrollRowViewHStackSpacing: CGFloat = scaledValue(width: 5)
    static let genericHorizontalScrollRowViewHStackSpacing: CGFloat = scaledValue(width: 5)
    static let genericHorizontalScrollTileViewHStackSpacing: CGFloat = scaledValue(width: 10)
    static let genericHorizontalScrollTileViewFrameHeight: CGFloat = scaledValue(height: 110)
    static let genericTileViewIconFrameWidth: CGFloat = scaledValue(width: 65)
    static let genericTileViewIconFrameHeight: CGFloat = scaledValue(height: 65)

    // Entry Views
    static let entryDetailViewButtonRoundedRectangleCornerRadius: CGFloat = scaledValue(width: 10)
    static let entryDetailViewButtonRoundedRectangleOpacity: CGFloat = 0.85
    static let addEntryViewButtonRoundedRectangleCornerRadius: CGFloat = scaledValue(width: 10)
    static let addEntryViewButtonRoundedRectangleOpacity: CGFloat = 0.85
}
