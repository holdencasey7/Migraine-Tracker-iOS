//
//  PlayingCatView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/14/25.
//

import SwiftUI

struct PlayingCatView: View {
    var body: some View {
        Image("FirstPlayingCat")
            .resizable()
            .scaledToFit()
            .aspectRatio(contentMode: .fit)
    }
}

#Preview {
    PlayingCatView()
}
