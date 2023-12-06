//
//  NidleView.swift
//  IOSClockApp
//
//  Created by Nagaraju on 06/12/23.
//

import Foundation
import SwiftUI
//MARK: - Custom Needle 
struct NeedleView : View {
    
    let width : CGFloat
    let height : CGFloat
    let color : Color
    var bottomLineHeight: CGFloat? = nil
    var filledCenter: Bool
    
    var body: some View {
        let quarterWidth = self.width / 4
        let halfheight = self.height / 2
        VStack(spacing:0){
            Rectangle()
                .fill(self.color)
                .frame(width: quarterWidth,height: halfheight - (self.width / 2 ) )
            
            if filledCenter {
                RoundedRectangle(cornerRadius: .infinity)
                    .fill(self.color)
                    .frame(width: self.width,height: self.width)
                
            } else {
                RoundedRectangle(cornerRadius: .infinity)
                    .stroke(self.color,lineWidth: quarterWidth)
                    .frame(width: self.width,height: self.width)
            }
            if let bottomLineHeight = self.bottomLineHeight {
                Rectangle()
                    .fill(self.color)
                    .frame(width: quarterWidth,height: bottomLineHeight)
                
            }
            Spacer()
        }.frame(width: self.width,height: self.height)
        
    }
}

