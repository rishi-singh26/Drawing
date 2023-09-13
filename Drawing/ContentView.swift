//
//  ContentView.swift
//  Drawing
//
//  Created by Rishi Singh on 13/09/23.
//

import SwiftUI

struct Arrow: InsettableShape {
    var insetAmount = 0.0
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arrow = self
        arrow.insetAmount += amount
        return arrow
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY / 3))
        path.addLine(to: CGPoint(x: rect.maxX / 1.5, y: rect.maxY / 3))
        path.addLine(to: CGPoint(x: rect.maxX / 1.5, y: rect.maxY))
        path.addLine(to: CGPoint(x: (rect.maxX / 1.5) / 2, y: rect.maxY))
        path.addLine(to: CGPoint(x: (rect.maxX / 1.5) / 2, y: rect.maxY / 3))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY / 3))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.closeSubpath()
        
        return path
    }
}

struct CyclingRectangle: View {
    var amount = 0.0
    var steps = 149
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: Double(value))
                    .strokeBorder(color(for: value, brightness: 1), lineWidth: 2)
            }
        }
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
    
}

struct ContentView: View {
    @State private var colorCycle = 0.0

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            CyclingRectangle(amount: colorCycle)
                            .frame(width: 300, height: 300)
            Spacer()
            
            Slider(value: $colorCycle)
                .padding()
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
