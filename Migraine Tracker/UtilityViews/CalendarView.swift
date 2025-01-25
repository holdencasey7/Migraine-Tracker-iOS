//
//  CalendarView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/3/25.
//

import SwiftUI
import SwiftData
import UIKit

struct CalendarView: UIViewRepresentable {
    var entries: [Entry]
    @Binding var selectedDate: Date?
    @Binding var showingEntries: Bool
    
    func makeUIView(context: Context) -> UICalendarView {
        let calendarView = UICalendarView()
        let selection = UICalendarSelectionSingleDate(delegate: context.coordinator)
        
        calendarView.selectionBehavior = selection
        calendarView.delegate = context.coordinator
        context.coordinator.calendarView = calendarView
        
        calendarView.availableDateRange = DateInterval(start: Date.distantPast, end: Date.distantFuture)
        calendarView.fontDesign = .rounded
        let todayComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        calendarView.setVisibleDateComponents(todayComponents, animated: true)
        return calendarView
    }
    
    func updateUIView(_ uiView: UICalendarView, context: Context) {
        uiView.delegate = context.coordinator
        context.coordinator.updateDecorations(with: entries)
        uiView.reloadDecorations(forDateComponents: entries.map {
            Calendar.current.dateComponents([.year, .month, .day], from: $0.timestamp)
        }, animated: true)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(entries: entries, selectedDate: $selectedDate, showingEntries: $showingEntries)
    }
    
    class Coordinator: NSObject, UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
        var calendarView: UICalendarView?
        var decorations: [Date: UICalendarView.Decoration] = [:]
        @Binding var selectedDate: Date?
        @Binding var showingEntries: Bool

        init(entries: [Entry], selectedDate: Binding<Date?>, showingEntries: Binding<Bool>) {
            self._selectedDate = selectedDate
            self._showingEntries = showingEntries
            super.init()
            updateDecorations(with: entries)
        }

        func updateDecorations(with entries: [Entry]) {
            decorations.removeAll()
            for entry in entries {
                let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: entry.timestamp)
                if let date = Calendar.current.date(from: dateComponents) {
                    decorations[date] = UICalendarView.Decoration.image(
                        UIImage(systemName: "circle.fill"),
                        color: UIColor(Color("Blue2")),
                        size: .medium
                    )
                }
            }
        }

        func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
            guard let dateComponents = dateComponents, let date = Calendar.current.date(from: dateComponents) else {
                print("Failed to convert selected date.")
                return
            }
            print("Date selected: \(date)")
            selectedDate = date
            showingEntries = true
        }

        func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
            if let date = Calendar.current.date(from: dateComponents) {
                return decorations[date]
            }
            return nil
        }
    }
}



//#Preview {
//    CalendarView(entries: [.init(timestamp: Date(), intensity: 1, notes: "1"), .init(timestamp: Date(), intensity: 2, notes: "2"), .init(timestamp: Date(), intensity: 3, notes: "3"), .init(timestamp: Date(), intensity: 4, notes: "4"), .init(timestamp: Date(), intensity: 5, notes: "5")])
//}
