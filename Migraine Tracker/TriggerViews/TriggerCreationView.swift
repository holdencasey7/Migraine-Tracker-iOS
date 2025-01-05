//
//  TriggerCreationView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 12/31/24.
//

import SwiftUI
import SwiftData

struct TriggerCreationView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State private var title: String = ""
    @State private var icon: String = ""
    @State private var category: TriggerCategory = .other
    
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            Text("Create a New Trigger")
                .font(.title)
                .padding()
            Form {
                TextField("Title", text: $title)
                    .padding()
                    .submitLabel(.done)
                IconPickerView(selectedIcon: $icon)
                    .padding()
                    .frame(height: 80)
                Picker("Category", selection: $category) {
                    ForEach(TriggerCategory.allCases) { category in
                        Text(category.rawValue).tag(category)
                    }
                }
            }
            Button("Create") {
                let trigger: Trigger = .init(title: title, icon: icon, category: category)
                modelContext.insert(trigger)
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
    TriggerCreationView(isPresented: .constant(true))
}
