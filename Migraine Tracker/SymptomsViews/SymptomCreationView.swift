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
    @State var icon: String = "DefaultTreatmentIcon"
    
    var body: some View {
        GeometryReader { geometry in
            
            VStack {
                Text("CREATE A NEW SYMPTOM")
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
                }
                Button("CREATE") {
                    let symptom: Symptom = .init(title: title, icon: icon)
                    modelContext.insert(symptom)
                    try? modelContext.save()
                    
                    title = ""
                    icon = "DefaultTreatmentIcon"
                    isPresented = false
                    
                    //TODO: should have a popup that says symptom added
                }
                .modifier(RoundedPinkButtonStyle())
            }
            .frame(maxWidth: .infinity)
            
        }
    }
}

#Preview {
    SymptomCreationView(isPresented: .constant(false))
}
