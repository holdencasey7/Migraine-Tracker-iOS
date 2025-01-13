//
//  BigRoundedPinkButtonStyle.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/12/25.
//


import SwiftUI

struct BigRoundedPinkButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Avenir", size: Constants.headerFontSize))
            .kerning(Constants.subtitleKerning)
            .minimumScaleFactor(0.8)
            .lineLimit(1)
            .allowsTightening(true)
            .padding()
            .padding(.horizontal, 10)
            .background(
                RoundedRectangle(cornerRadius: Constants.entryDetailViewButtonRoundedRectangleCornerRadius)
                    .fill(Color("FirstLightPink").opacity(Constants.entryDetailViewButtonRoundedRectangleOpacity))
            )
    }
}
