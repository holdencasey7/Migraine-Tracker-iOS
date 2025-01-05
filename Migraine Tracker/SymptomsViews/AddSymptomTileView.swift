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
                .scaledToFit()
            Text("New Symptom")
                .font(Font.custom("Avenir", size: 19))
                .multilineTextAlignment(.center)
        }
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
