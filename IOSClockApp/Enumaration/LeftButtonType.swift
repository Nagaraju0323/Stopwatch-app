//
//  LeftButtonType.swift
//  IOSClockApp
//
//  Created by Nagaraju on 07/12/23.
//

import Foundation

//MARK: Left Button Type
///passive Type - passive type should stop type
///ActiveType - acive type is used to start
///reset - reset button clear  the all Timers

enum LeftButtonType {
    case lapPassive
    case lapActive
    case reset
}
