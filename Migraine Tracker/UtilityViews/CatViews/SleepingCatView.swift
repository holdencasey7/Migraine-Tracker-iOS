//
//  SleepingCatView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/14/25.
//

import SwiftUI

struct SleepingCatView: View {
    var body: some View {
        Image("FirstSleepingCat")
            .resizable()
            .scaledToFit()
            .aspectRatio(contentMode: .fit)
    }
}

#Preview {
    SleepingCatView()
}
