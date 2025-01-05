//
//  SwiftUIView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 12/31/24.
//  ChatGPT assisted on this specific file
//

import SwiftUI

struct CustomIntensitySliderView: UIViewRepresentable {
    @Binding var value: Double
    let range: ClosedRange<Double> = 1...5
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        slider.minimumValue = Float(range.lowerBound)
        slider.maximumValue = Float(range.upperBound)
        slider.value = Float(value)
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.valueChanged(_:)),
            for: .valueChanged
        )
        slider.setThumbImage(getThumbImage(for: Int(value)), for: .normal)
        return slider
    }

    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = Float(value)
        uiView.setThumbImage(getThumbImage(for: Int(value)), for: .normal)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: CustomIntensitySliderView

        init(_ parent: CustomIntensitySliderView) {
            self.parent = parent
        }

        @objc func valueChanged(_ sender: UISlider) {
            // Round the slider's value to the nearest integer for step size of 1
            let roundedValue = round(Double(sender.value))
            parent.value = roundedValue
            sender.value = Float(roundedValue) // Update UISlider's value
            sender.setThumbImage(parent.getThumbImage(for: Int(roundedValue)), for: .normal)
        }
    }

    private func getThumbImage(for value: Int) -> UIImage {
        let emoji: String
        switch value {
        case 1: emoji = "🙁"
        case 2: emoji = "☹️"
        case 3: emoji = "😣"
        case 4: emoji = "😫"
        case 5: emoji = "😭"
        default: emoji = "❓"
        }

        let size = CGSize(width: 40, height: 40)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.clear.set()
        UIRectFill(CGRect(origin: .zero, size: size))
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 32)
        ]
        let textSize = emoji.size(withAttributes: attributes)
        let textRect = CGRect(
            x: (size.width - textSize.width) / 2,
            y: (size.height - textSize.height) / 2,
            width: textSize.width,
            height: textSize.height
        )
        emoji.draw(in: textRect, withAttributes: attributes)
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
}

//#Preview {
//    CustomIntensitySliderView()
//}
