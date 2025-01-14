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

    var body: some View {
        ZStack {
            Image("HomeViewBackground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                MigraineCatView()
                    .padding()
                GiantAddEntryButtonView(contentViewSelection: $contentViewSelection)
                    .padding()
                Spacer()
            }
        }
    }
}






#Preview {
    HomeView(contentViewSelection: .constant(0))
}
