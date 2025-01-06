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
        VStack {
            Image(item.icon ?? "DefaultSymptomIcon")
                .resizable()
                .scaledToFit()
            Text(item.title)
                .font(Font.custom("Avenir", size: Constants.genericTileViewTitleFontSize))
                .frame(maxWidth: Constants.genericTileViewFrameMaxWidth)
        }
    }
}

#Preview {
    GenericTileView(item: Trigger(title: "Physical Exertion", icon: "LifestyleTriggerIcon", category: TriggerCategory.lifestyle))
}
