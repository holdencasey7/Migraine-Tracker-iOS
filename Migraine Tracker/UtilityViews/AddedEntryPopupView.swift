//
//  AddedEntryPopupView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/6/25.
//

import SwiftUI

struct AddedEntryPopupView: View {
    @Binding var isVisible: Bool

    var body: some View {
        if isVisible {
            ZStack {
                Color.clear
                    .edgesIgnoringSafeArea(.all)
                    .background(.thinMaterial.opacity(0.95))
                Image("EntryAddedCat")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 200, height: 200)
                    .shadow(radius: 5)
                    .transition(.opacity)
                    .animation(.easeOut(duration: 1.0), value: isVisible)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation {
                                isVisible = false
                            }
                        }
                    }
                    .padding(100)
            }
            
        }
    }
}

#Preview {
    AddedEntryPopupView(isVisible: .constant(true))
}
