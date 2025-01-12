//
//  GenericRowView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/2/25.
//

import SwiftUI

struct GenericRowView<T : GenericTriggerTreatmentSymptom>: View {
    var item: T
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Image(item.icon ?? "DefaultTriggerIcon")
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(1, contentMode: .fit)
//                    .frame(width: geometry.size.width * 0.15, height: geometry.size.width * 0.15)
                Text(item.title)
                    .font(Font.custom("Avenir", size: Constants.genericRowViewTitleFontSize))
                    .minimumScaleFactor(0.8)
                    .lineLimit(1)
                    .allowsTightening(true)
                Spacer()
            }
//            .frame(width: geometry.size.width * 0.15, height: geometry.size.width * 0.15)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

//#Preview {
//    GenericRowView()
//}
