//
//  TickShape.swift
//  IOSClockApp
//
//  Created by Nagaraju on 06/12/23.
//

import Foundation
import SwiftUI

//MARK: - Tick shape
//pass to the tick custom height based on the add custom line   

struct TickShape : Shape {

    let tickHeight : CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY + self.tickHeight))
        return path
    }
    
}

