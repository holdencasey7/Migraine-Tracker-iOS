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
    @State var presentCalendarSheet: Bool = false
    @State var isEntryDetailVisible: Bool = false
    
    var body: some View {
        
        VStack {
            EntryListView(isEntryDetailVisible: $isEntryDetailVisible, entries: entries)
                .background(Color("FirstLightPink").edgesIgnoringSafeArea(.all))
            if !isEntryDetailVisible {
                Button(action: {presentCalendarSheet = true}) {
                    Text("CALENDAR VIEW")
                        .kerning(3)
                        .font(Font.custom("Avenir", size: 19))
                        .padding(5)
                        .padding(.trailing, 39)
                        .padding(.leading, 39)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white.opacity(0.85))
                        )
                }
                .sheet(isPresented: $presentCalendarSheet) {
                    EntryCalendarView(entries: entries, isPresented: $presentCalendarSheet)
                }
                .padding(.bottom, 20)
                .padding(.top, 20)
            }
        }
        .background(Color("FirstLightPink").edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    EntriesView()
}
