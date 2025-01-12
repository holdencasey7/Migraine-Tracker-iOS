// Constants.swift
// Migraine Tracker
// Created by Holden Casey on 1/5/25.

import Foundation
import SwiftUI

enum Constants {

    // Home View
    

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
    static let weatherViewRoundedRectangleCornerRadius: CGFloat = 30
    static let weatherViewRoundedRectanlgeBorderWidth: CGFloat = 1
    static let weatherViewInnerHStackSpacing: CGFloat = 1
    static let weatherViewOuterHStackSpacing: CGFloat = 35

    // Generic Views
    static let genericTileViewTitleFontSize: CGFloat = 14
    static let genericRowViewTitleFontSize: CGFloat = 19
    static let genericListViewVStackSpacing: CGFloat = 5
    static let genericIconlessRowViewTitleFontSize: CGFloat = 19
    static let genericIconlessHorizontalScrollRowViewHStackSpacing: CGFloat = 5
    static let genericHorizontalScrollRowViewHStackSpacing: CGFloat = 5
    static let genericHorizontalScrollTileViewHStackSpacing: CGFloat = 10

    // Entry Views
    static let entryDetailViewButtonRoundedRectangleCornerRadius: CGFloat = 10
    static let entryDetailViewButtonRoundedRectangleOpacity: CGFloat = 0.85
    static let addEntryViewButtonRoundedRectangleCornerRadius: CGFloat = 10
    static let addEntryViewButtonRoundedRectangleOpacity: CGFloat = 0.85
    static let addEntrySubmitButtonFontSize: CGFloat = 25
    
    // Insights View
    static let minimumRequiredEntryCount: Int = 5
    static let leadingTriggerTreatmentFontSize: CGFloat = 21
    static let averageDurationFontSize: CGFloat = 21
    static let averageWeatherFontSize: CGFloat = 21
}
