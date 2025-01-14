//
//  MigraineCatView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/13/25.
//

import SwiftUI

struct MigraineCatView: View {
    var body: some View {
        Image("FirstMigraineCat")
            .resizable()
            .scaledToFit()
            .aspectRatio(contentMode: .fit)
    }
}

#Preview {
    MigraineCatView()
}
