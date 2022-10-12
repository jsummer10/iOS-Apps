//
//  DashDivider.swift
//  City-Sights
//
//  Created by Jacob Summerville on 10/12/22.
//

import SwiftUI

struct DashDivider: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                path.move(to: CGPoint.zero)
                path.addLine(to: CGPoint(x: geometry.size.width, y: 0))
            }
            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
            .foregroundColor(.gray)
        }.frame(height: 1)
    }
}
