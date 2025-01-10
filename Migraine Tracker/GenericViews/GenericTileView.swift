//
//  GenericTileView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/3/25.
//

import SwiftUI

struct GenericTileView<T: GenericTriggerTreatmentSymptom>: View {
    var item: T
    var body: some View {
            VStack() {
                Image(item.icon ?? "DefaultSymptomIcon")
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                Text(item.title)
                    .font(Font.custom("Avenir", size: Constants.genericTileViewTitleFontSize))
                    .minimumScaleFactor(0.8)
                    .lineLimit(1)
                    .allowsTightening(true)
                Spacer()
            }
            .aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    GenericTileView(item: Trigger(title: "Physical Exertion", icon: "LifestyleTriggerIcon", category: TriggerCategory.lifestyle))
}
