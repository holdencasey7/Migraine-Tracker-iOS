//
//  EntryDetailSTTHeaderStyle.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/10/25.
//

import SwiftUI

struct EntryDetailSTTHeaderStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
            .kerning(Constants.subtitleKerning)
            .minimumScaleFactor(0.8)
            .lineLimit(1)
            .allowsTightening(true)
    }
}
