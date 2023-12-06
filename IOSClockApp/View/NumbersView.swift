//
//  NumbersView.swift
//  IOSClockApp
//
//  Created by Nagaraju on 06/12/23.
//

import Foundation
import SwiftUI
//MARK: - Custom NumbersView
///defined numbers and font and colors 
struct NumbersView : View {
    
    let numbers: [Int]
    let font:Font
    let textColor: Color
    
    var body: some View {
        ForEach(numbers.indices, id: \.self) { index in
            
            let degree:Double = Double.pi * 2 / Double(self.numbers.count)
            let itemDegree = degree * Double(index)
            VStack {
                
                Text("\(self.numbers[index])")
                    .rotationEffect(.radians(-itemDegree))
                    .foregroundColor(textColor)
                    .font(self.font)
                Spacer()
            }.rotationEffect(.radians(itemDegree))
            
            
        }
        
    }
}
