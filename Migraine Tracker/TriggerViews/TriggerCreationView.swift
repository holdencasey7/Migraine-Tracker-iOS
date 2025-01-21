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
    @State private var icon: String = "DefaultTreatmentIcon"
    @State private var category: TriggerCategory = .other
    
    @Binding var isPresented: Bool
    
    var body: some View {
        GeometryReader { geometry in
            
            VStack {
                Text("CREATE A NEW TRIGGER")
                    .font(Font.custom("Avenir", size: Constants.headerFontSize))
                    .kerning(Constants.creationViewSectionHeaderKerning)
                    .minimumScaleFactor(0.9)
                    .lineLimit(1)
                    .allowsTightening(true)
                    .padding()
                Form {
                    Section {
                        TextField("Title", text: $title)
                            .padding()
                            .submitLabel(.done)
                    } header: {
                        Text("Choose a Name")
                            .font(Font.custom("Avenir", size: Constants.creationViewSectionHeaderFontSize))
                            .kerning(Constants.creationViewSectionHeaderKerning)
                    }
                    
                    Section {
                        SelectAnyIconView(selectedIcon: $icon)
                            .frame(height: geometry.size.height * 0.15)
                    } header: {
                        Text("Select an Icon")
                            .font(Font.custom("Avenir", size: Constants.creationViewSectionHeaderFontSize))
                            .kerning(Constants.creationViewSectionHeaderKerning)
                    }
                    
                    Section {
                        Picker("Category", selection: $category) {
                            ForEach(TriggerCategory.allCases) { category in
                                Text(category.rawValue).tag(category)
                            }
                        }
                    } header: {
                        Text("Select a Category")
                            .font(Font.custom("Avenir", size: Constants.creationViewSectionHeaderFontSize))
                            .kerning(Constants.creationViewSectionHeaderKerning)
                    }
                }
                Button("CREATE") {
                    let trigger: Trigger = .init(title: title, icon: icon, category: category)
                    modelContext.insert(trigger)
                    try? modelContext.save()
                    
                    title = ""
                    icon = "DefaultTreatmentIcon"
                    category = .other
                    isPresented = false
                }
                .modifier(RoundedPinkButtonStyle())
            }
            .frame(maxWidth: .infinity)
            
        }
    }
}

#Preview {
    TriggerCreationView(isPresented: .constant(true))
}
