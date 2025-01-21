//
//  EntryRemainingCatView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/13/25.
//

import SwiftUI

struct EntryRemainingCatView: View {
    var numEntries: Int
    var body: some View {
        Image("entrycat\(numEntries)")
            .resizable()
            .scaledToFit()
            .aspectRatio(contentMode: .fit)
    }
}

#Preview {
    EntryRemainingCatView(numEntries: 4)
}
