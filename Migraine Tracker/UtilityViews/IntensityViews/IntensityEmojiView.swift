//
//  IntensityEmojiView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 12/30/24.
//

import SwiftUI

struct IntensityEmojiView: View {
    var intensity: Int
    var body: some View {
        if intensity == 1 {
            Text("🙁")
        } else if intensity == 2 {
            Text("☹️")
        } else if intensity == 3 {
            Text("😣")
        } else if intensity == 4 {
            Text("😫")
        } else if intensity == 5{
            Text("😭")
        } else {
            Text("❓")
        }
    }
}

#Preview {
    IntensityEmojiView(intensity: 1)
}
