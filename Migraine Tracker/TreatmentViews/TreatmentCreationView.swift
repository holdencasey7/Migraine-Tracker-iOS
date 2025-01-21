//
//  TreatmentCreationView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 12/31/24.
//

import SwiftUI

struct TreatmentCreationView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State private var title: String = ""
    @State private var icon: String = "DefaultTreatmentIcon"
    @State private var category: TreatmentCategory = .other
    @State private var defaultDosage: String = ""
    @State private var defaultFrequency: Int = 1
//    @State private var defaultDuration: TimeInterval = .zero
    @State private var defaultOtherNotes: String = ""
    
    @Binding var isPresented: Bool
    
    var body: some View {
        GeometryReader { geometry in
            
            VStack {
                Text("CREATE A NEW TREATMENT")
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
                            ForEach(TreatmentCategory.allCases) { category in
                                Text(category.rawValue).tag(category)
                            }
                        }
                    } header: {
                        Text("Select a Category")
                            .font(Font.custom("Avenir", size: Constants.creationViewSectionHeaderFontSize))
                            .kerning(Constants.creationViewSectionHeaderKerning)
                    }
                    
                    Section {
                        TextField("Dosage", text: $defaultDosage)
                            .autocapitalization(.none)
                            .padding()
                            .submitLabel(.done)
                        Stepper("Times Taken: \(defaultFrequency)", value: $defaultFrequency, in: 0...10)
                            .padding(.horizontal)
                        //TODO: duration
                        TextField("Other notes", text: $defaultOtherNotes)
                            .autocapitalization(.none)
                            .padding()
                            .submitLabel(.done)
                    } header: {
                        Text("Set Default Notes")
                            .font(Font.custom("Avenir", size: Constants.creationViewSectionHeaderFontSize))
                            .kerning(Constants.creationViewSectionHeaderKerning)
                    }

                }
                Button("CREATE") {
                    let treatment: Treatment = .init(title: title, icon: icon, category: category)
                    treatment.defaultDosage = defaultDosage
                    treatment.defaultFrequency = defaultFrequency
                    treatment.defaultOtherNotes = defaultOtherNotes
                    modelContext.insert(treatment)
                    try? modelContext.save()
                    isPresented = false
                    
                    title = ""
                    icon = "DefaultTreatmentIcon"
                    category = .other
                    defaultDosage = ""
                    defaultFrequency = 1
//                    defaultDuration = .zero
                    defaultOtherNotes = ""
                }
                .modifier(RoundedPinkButtonStyle())
            }
            .frame(maxWidth: .infinity)
            
        }
    }
}

#Preview {
    TreatmentCreationView(isPresented: .constant(true))
}
