//
//  EntriesView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 12/29/24.
//

import SwiftUI
import SwiftData

struct EntriesView: View {
    @Query private var entries: [Entry]
    @State var isEntryDetailVisible: Bool = false
    
    var body: some View {
        
        VStack {
            EntryListView(isEntryDetailVisible: $isEntryDetailVisible, entries: entries)
                .background(Color("FirstLightPink").edgesIgnoringSafeArea(.all))
        }
        .background(Color("FirstLightPink").edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    EntriesView()
}
