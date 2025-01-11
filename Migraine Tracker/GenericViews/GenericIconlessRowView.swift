//
//  GenericIconlessRowView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/3/25.
//

import SwiftUI

struct GenericIconlessRowView<T: GenericTriggerTreatmentSymptom>: View {
    var item: T
    var includeComma: Bool = false
    var hasNote: Bool = false
    var body: some View {
        HStack {
            Text("\(item.title)\(includeComma ? ", " : "")")
                .font(Font.custom("Avenir", size: Constants.genericIconlessRowViewTitleFontSize))
            // Bold if has a note
                .fontWeight(hasNote ? .bold : .regular)
                .underline(hasNote)
        }
    }
}

//#Preview {
//    GenericIconlessRowView()
//}
