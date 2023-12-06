//
//  LapItemPresenter.swift
//  IOSClockApp
//
//  Created by Nagaraju on 06/12/23.
//

import Foundation
import SwiftUI

struct LapItemPresenter:Identifiable {
    let id = UUID()
    var lap:String = ""
    var time : String = ""
    var type: lapType = .normal
}
