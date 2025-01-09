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
            contentViewSelection = 2
        }) {
            Text("Log New Entry")
                .font(Font.custom("Avenir", size: 30))
                .padding()
                .padding(.horizontal, 10)
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("FirstLightPink"))
        )
    }
}

#Preview {
    GiantAddEntryButtonView(contentViewSelection: .constant(0))
}
