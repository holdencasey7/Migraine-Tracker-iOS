//
//  HomeView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 12/29/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Binding var contentViewSelection: Int
    @Query var entries: [Entry]
    @State var localEntries: [Entry] = []
    @State var time: Date = Date()

    var body: some View {
        ZStack {
            Image("HomeViewBackground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
//                if false /* time is night */{
//                    SleepingCatView()
//                        .padding()
//                } else if localEntries.count > 10 {
//                    PlayingCatView()
//                        .padding()
//                } else {
//                    MigraineCatView()
//                        .padding()
//                }
                MigraineCatView()
                    .padding()
                GiantAddEntryButtonView(contentViewSelection: $contentViewSelection)
                    .padding()
                Spacer()
            }
        }
        .task {
            localEntries = Array(entries)
        }
        .onAppear {
            time = Date()
        }
    }
}






#Preview {
    HomeView(contentViewSelection: .constant(0))
}
