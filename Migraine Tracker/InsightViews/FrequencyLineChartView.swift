import SwiftUI
import Charts

struct FrequencyLineChartView: View {
    var entries: [Entry]
    @State private var granularity: TimeGranularity = .day
    
    var body: some View {
        let granularity = determineGranularity(entries: entries)
        let groupedEntries = groupEntries(entries: entries, by: granularity)
        GeometryReader { geometry in
            VStack {
                Chart {
                    // Create a line chart with smooth curves
                    ForEach(groupedEntries, id: \.0) { dataPoint in
                        LineMark(
                            x: .value("Date", dataPoint.0),
                            y: .value("Entries", dataPoint.1)
                        )
                        .lineStyle(StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                        .interpolationMethod(.cardinal) // Smooth curve
                    }
                }
                .padding()
                .chartYAxis {
                    AxisMarks(position: .trailing, values: .automatic(desiredCount: 5)) { value in
                        let intValue = value.as(Int.self) ?? 0
                        AxisValueLabel {
                            Text("\(intValue)")  // Display entries count
                        }
                        
                    }
                }
                .chartXAxis {
                    AxisMarks(position: .bottom, values: .automatic) { value in
                        if let dateString = value.as(String.self) {
                            AxisValueLabel {
                                Text(getFormattedDate(dateString, granularity: granularity))
                                    .font(.caption)
                                    .foregroundColor(.black)
                            }
                        }
                    }
                }
                /*.frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.3)*/ // Adjust chart height as needed
                .padding()
                Text("Entries per \(granularity == .day ? "Day" : granularity == .week ? "Week" : "Month")")
                    .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                //                .kerning(Constants.subtitleKerning)
                    .padding(.horizontal)
                    .padding(.bottom)
                    .underline(true)
            }
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white.opacity(0.5))
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
            )
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    
    // Helper function to format the date based on granularity
    func getFormattedDate(_ dateString: String, granularity: TimeGranularity) -> String {
        let dateFormatter = DateFormatter()
        // Ensure proper date format parsing
        dateFormatter.dateFormat = "yyyy-MM-dd" // Assuming the dateString is in this format
        guard let date = dateFormatter.date(from: dateString) else { return "" }
        
        switch granularity {
        case .day, .week:
            // For day and week, format as MM/dd
            dateFormatter.dateFormat = "MM/dd"
        case .month:
            // For month, format as month abbreviation
            dateFormatter.dateFormat = "MMM"
        }
        
        return dateFormatter.string(from: date)
    }
}

#Preview {
    FrequencyLineChartView(entries: [])
}
