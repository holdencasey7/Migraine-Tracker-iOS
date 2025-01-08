//
//  GiantAddEntryButtonView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/6/25.
//

import SwiftUI

struct GiantAddEntryButtonView: View {
    @Binding var contentViewSelection: Int
    var body: some View {
        Button(action: {
            contentViewSelection = 1
        }) {
            Image(systemName: "plus")
                .font(Font.system(size: 100))
        }
    }
}

#Preview {
    GiantAddEntryButtonView(contentViewSelection: .constant(0))
}
