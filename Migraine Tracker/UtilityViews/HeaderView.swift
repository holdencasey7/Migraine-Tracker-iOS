//
//  HeaderView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/3/25.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        Text("M I G R A I N E    T R A C K E R")
            .font(Font.custom("Avenir", size: Constants.headerFontSize))
            .foregroundColor(Color.black)
    }
    

}

#Preview {
    HeaderView()
}
