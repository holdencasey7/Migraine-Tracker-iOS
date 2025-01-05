//
//  SortPickerView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/2/25.
//

import SwiftUI

struct EntrySortPickerView: View {
    enum SortMethod: String, CaseIterable, Identifiable {
        case timestampDescending = "Date (Newest First)"
        case timestampAscending = "Date (Oldest First)"
        case intensityDescending = "Intensity (Highest First)"
        case intensityAscending = "Intensity (Lowest First)"
        
        var id: String { self.rawValue }
        
        var sortClosure: (Entry, Entry) -> Bool {
            switch self {
            case .timestampDescending:
                return { $0.timestamp > $1.timestamp }
            case .timestampAscending:
                return { $0.timestamp < $1.timestamp }
            case .intensityDescending:
                return { $0.intensity > $1.intensity }
            case .intensityAscending:
                return { $0.intensity < $1.intensity }
            }
        }
    }
    
    @Binding var selectedSortMethod: SortMethod
    var body: some View {
        Menu {
            Picker("Sort By", selection: $selectedSortMethod) {
                ForEach(SortMethod.allCases) { method in
                    Text(method.rawValue).tag(method)
                }
            }
        } label: {
            Text(selectedSortMethod.rawValue)
                .font(Font.custom("Avenir", size: 17))
                .padding()
                .padding(.bottom, -10)
                .padding(.top, -10)
                .background(Color.white.opacity(0.6), in: RoundedRectangle(cornerRadius: 10))
        }.id(selectedSortMethod)
    }
}

#Preview {
    EntrySortPickerView(selectedSortMethod: .constant(.timestampDescending))
}
