//
//  AddSymptomTileView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/1/25.
//

import SwiftUI

struct AddSymptomTileView: View {
    @State var showAddSymptomSheet: Bool = false
    
    var body: some View {
        VStack {
            Image("AddSymptomIcon")
                .resizable()
                .aspectRatio(1, contentMode: .fit)
            Text("New Symptom")
                .font(Font.custom("Avenir", size: Constants.genericTileViewTitleFontSize))
                .minimumScaleFactor(0.8)
                .lineLimit(1)
                .allowsTightening(true)
            Spacer()
        }
        .aspectRatio(1, contentMode: .fit)
        .onTapGesture {
            showAddSymptomSheet = true
        }
        .background(showAddSymptomSheet ? Color("LightGrey") : Color.clear)
        .background(in: RoundedRectangle(cornerRadius: 10))
        .sheet(isPresented: $showAddSymptomSheet) {
            SymptomCreationView(isPresented: $showAddSymptomSheet)
        }
    }
}

#Preview {
    AddSymptomTileView()
}
