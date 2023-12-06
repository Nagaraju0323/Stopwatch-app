//
//  ActionButtonStyle.swift
//  IOSClockApp
//
//  Created by Nagaraju on 06/12/23.
//

import Foundation
import SwiftUI

//MARK: - ActionButtonStyle
///ActionButtonStyle  protocol that you can adopt to define a
///custom style for buttons created using the Button view.

struct ActionButtonStyle : ButtonStyle {
    let textColor:Color
    let backgroundColor:Color
    
    func makeBody(configuration: Configuration) -> some View {

        configuration.label
            .frame(width: 80,height: 80)
            .overlay(RoundedRectangle (cornerRadius: .infinity)
                .stroke(self.backgroundColor, lineWidth: 2))
            .background(Circle().foregroundColor(self.backgroundColor).padding(4))
            .foregroundColor(self.textColor)
    }
}
