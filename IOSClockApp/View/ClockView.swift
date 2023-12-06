//
//  ClockView.swift
//  IOSClockApp
//
//  Created by Nagaraju on 06/12/23.
//

import Foundation
import SwiftUI

//MARK: clock View
/// it can show circle clock with divders and custom hight and color to adjst the size
/// 
struct ClockView: View {
    
    let count : Int
    let longDevider: Int
    let longTickHeight:CGFloat
    let tickHeight : CGFloat
    let tickwidth: CGFloat
    let highlightedColorDivider:Int
    let highlightedColor:Color
    let normalColor:Color

    var body: some View{
        ZStack {
            ForEach(0..<count) { index in
                let height = (index % self.longDevider == 0) ? self.longTickHeight : self.tickHeight
                let color = (index % self.highlightedColorDivider == 0) ? self.highlightedColor : self.normalColor
                let degree: Double = Double.pi * 2 / Double(self.count)
                TickShape(tickHeight: height).stroke(lineWidth: self.tickwidth)
                
                    .rotationEffect(.radians(degree * Double(index)))
                    .foregroundColor(color)
            }
        }
        
    }
    
}
