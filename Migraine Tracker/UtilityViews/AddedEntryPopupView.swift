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
                Text("Entry Added!")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
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
            }
            
        }
    }
}

#Preview {
    AddedEntryPopupView(isVisible: .constant(true))
}
