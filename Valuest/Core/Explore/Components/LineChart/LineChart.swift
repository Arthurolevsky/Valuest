//
//  LineChartView.swift
//  Valuest
//
//  Created by Arthur Olevsky on 01.05.2022.
//

import SwiftUI


struct LineChart: View {
    
    var data: [CGFloat]
    
    var body: some View {
        
        
        VStack(alignment: .leading, spacing: 2) {
            
            VStack(alignment: .leading) {
                Text("GSPC")
                    .font(.footnote.bold())
                
                Text("S&P 500")
                    .foregroundColor(Color("textSecondary"))
                    .font(.system(size: 9))
            }
            .padding([.top, .horizontal], 8)

            
            
            GeometryReader { geometry in
                
                ZStack {

                    let points = data.enumerated().compactMap { item -> CGPoint in
                        let x = geometry.size.width * CGFloat(item.offset) / CGFloat(data.count - 1)
                        let y = CGFloat((1 - data[item.offset])) * geometry.size.height
                        
                        return CGPoint(x: x, y: y)
                    }
                    
                    Path { path in

                        guard data.count > 1 else { return }
                        
                        let start = data[0]
                        path.move(to: CGPoint(x: 0, y: (1 - start) * geometry.size.height))
                        path.addLines(points)

                    }
                    .strokedPath(StrokeStyle(lineWidth: 2.5, lineCap: .round, lineJoin: .round))
                    .fill(Color.green)

                    
                    LinearGradient(colors: [Color("GradientStart").opacity(0.6),
                                            Color("GradientStart").opacity(0.3),
                                            Color("GradientStart").opacity(0.1)], startPoint: .top, endPoint: .bottom)
                        .clipShape(Path { path in

                            guard data.count > 1 else { return }

                            let start = data[0]
                            path.move(to: CGPoint(x: 0, y: (1 - start) * geometry.size.height))

                            path.addLines(points)

                            path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
                            path.addLine(to: CGPoint(x: 0, y: geometry.size.height))

                        })
                }
            }
            .overlay(alignment: .bottomTrailing) {
                VStack (alignment: .trailing){
                    Text("442.92")
                        .font(.footnote)
                    HStack(spacing: 4) {
                        Text("0.30%")
                            .foregroundColor(.red)
                        Text("-1.38")
                    }
                    .font(.caption2)
                }
                .padding(8)
            }
        }
        .background(Color("CardBackground"))
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
    }
}
