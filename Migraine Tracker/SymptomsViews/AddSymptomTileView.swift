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
                .frame(width: Constants.genericTileViewIconFrameWidth, height: Constants.genericTileViewIconFrameHeight)
            Text("New Symptom")
                .multilineTextAlignment(.center)
                .font(Font.custom("Avenir", size: Constants.genericTileViewTitleFontSize))
                .frame(maxWidth: Constants.genericTileViewFrameMaxWidth)
            Spacer()
        }
        .onTapGesture {
            showAddSymptomSheet = true
        }
        .background(showAddSymptomSheet ? Color("LightGrey") : Color.clear)
        .background(in: RoundedRectangle(cornerRadius: 10))
        .sheet(isPresented: $showAddSymptomSheet) {
            SymptomCreationView(isPresented: $showAddSymptomSheet)
        }
        .frame(width: Constants.genericTileViewFrameMaxWidth, height: Constants.genericTileViewFrameMaxHeight)
    }
}

#Preview {
    AddSymptomTileView()
}
