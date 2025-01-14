//
//  TriggerGridView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 12/29/24.
//

import SwiftUI

struct TriggerSelectableMenuView: View {
    var triggers: [Trigger]
    @State var selectedTriggers: [Trigger]
    @Binding var finalSelectedTriggers: [Trigger]
    @Binding var isPresented: Bool
    
    @State private var searchText = ""
    @State var filteredTriggers: [Trigger] = []
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                List(TriggerCategory.allCases) { category in
                    Section {
                        ForEach(filteredTriggers.filter({$0.category == category}).sorted(by: { $0.title < $1.title
                        })) { trigger in
                            let selected = selectedTriggers.contains(trigger)
                            HStack{
                                TriggerRowView(trigger: trigger)
                                    .frame(height: geometry.size.width * 0.15)
                                Spacer()
                                if selected {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(Color("PrettyPink"))
                                }
                            }
                            .contentShape(Rectangle())
                            .listRowBackground(selected ? Color("LightBlue") : Color.white)
                            .onTapGesture {tapGesture in
                                if !selected {
                                    selectedTriggers.append(trigger)
                                } else {
                                    selectedTriggers.removeAll(where: { $0 == trigger })
                                }
                            }
                        }
                    } header: {
                        Text(category.rawValue)
                    }
                } .searchable(text: $searchText)
                    .onChange(of: searchText) {
                        if searchText.isEmpty {
                            filteredTriggers = triggers
                        } else {
                            filteredTriggers = triggers.filter({$0.title.lowercased().starts(with: searchText.lowercased())})
                        }
                    }
                    .onAppear {
                        filteredTriggers = triggers
                    }
            }
        }
        HStack {
            Spacer()
            Button(action: saveTriggers) {
                Text("SAVE")
            }
            .font(Font.custom("Avenir", size: Constants.addEntrySubmitButtonFontSize))
            .padding()
            Spacer()
        }
    }
    private func saveTriggers() {
        finalSelectedTriggers = selectedTriggers
        isPresented = false
    }
}

//#Preview {
//    let triggers = [
//        Trigger(title: "Stress", icon: "stress", category: TriggerCategory.lifestyle),
//        Trigger(title: "Poor Sleep", icon: "sleep", category: TriggerCategory.lifestyle),
//        Trigger(title: "Irregular Meals", icon: "meals", category: TriggerCategory.lifestyle),
//        Trigger(title: "Exercise", icon: "exercise", category: TriggerCategory.lifestyle),
//    ]
//    TriggerMenuView(triggers: triggers, selectedTriggers: [], finalSelectedTriggers: .constant([]), isPresented: .constant(false))
//}
