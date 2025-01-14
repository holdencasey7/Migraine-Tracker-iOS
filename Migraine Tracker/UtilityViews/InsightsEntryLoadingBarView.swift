//
//  InsightsEntryLoadingBarView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/13/25.
//

import SwiftUI

struct InsightsEntryLoadingBarView: View {
    var numEntries: Int
    var body: some View {
        Image("loadingbar\(numEntries)")
            .resizable()
            .scaledToFit()
            .aspectRatio(contentMode: .fit)
    }
}

#Preview {
    InsightsEntryLoadingBarView(numEntries: 5)
}
