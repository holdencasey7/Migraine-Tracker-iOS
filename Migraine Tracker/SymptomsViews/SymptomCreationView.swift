//
//  SymptomCreationView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/1/25.
//

import SwiftUI
import SwiftData

struct SymptomCreationView: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var isPresented: Bool
    
    @State var title: String = ""
    @State var icon: String = ""
    
    var body: some View {
        VStack {
            Text("Create a New Symptom")
                .font(.title)
                .padding()
            Form {
                TextField("Title", text: $title)
                    .padding()
                    .submitLabel(.done)
                IconPickerView(selectedIcon: $icon)
                    .padding()
                    .frame(height: 80)
            }
            Button("Create") {
                let symptom: Symptom = .init(title: title, icon: icon)
                modelContext.insert(symptom)
                try? modelContext.save()
                isPresented = false
            }
            .font(.title2)
            .padding(5)
            .padding(.trailing, 10)
            .padding(.leading, 10)
            .background(Color("LightGrey"), in: RoundedRectangle(cornerRadius: 10))
        }
    }
}

#Preview {
    SymptomCreationView(isPresented: .constant(false))
}
