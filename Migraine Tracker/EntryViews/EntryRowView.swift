//
//  EntryRowView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 12/29/24.
//

import SwiftUI

struct EntryRowView: View {
    var entry: Entry
    var body: some View {
        HStack {
            Text(entry.timestamp.formatted(date: .abbreviated, time: .shortened))
                .font(Font.custom("Avenir", size: 17))
                .padding(.leading, 10)
            Spacer()
            IntensityIconView(intensity: entry.intensity)
                .padding(3)
            
        }
    }
}

//#Preview {
//    EntryRowView(entry: .init(timestamp: Date(), intensity: 2, notes: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."))
//}
