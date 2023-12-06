//
//  ContentView.swift
//  IOSClockApp
//
//  Created by Nagaraju on 06/12/23.
//

import SwiftUI

struct ContentView: View {
    
    private let marginLeading: CGFloat = 16
    private let marginTraling: CGFloat = 16
    private let marginTop : CGFloat = 12
    private let tickHeight :CGFloat = 8
    private let longTickHeight :CGFloat = 14
    private let tickWidth:CGFloat = 2
    private let numberPadding:CGFloat = 40
    private let miniNumberPadding:CGFloat = 24
    private let actionButtonPadding: CGFloat = 16
    private let miniLongTickHeight: CGFloat = 9
    private let miniTickHeight: CGFloat = 6
    
    @ObservedObject private var viewModel:ViewModel = ViewModel()
    
    var body: some View {
        ZStack {
            Color.backgroundColor.ignoresSafeArea(.all)
            GeometryReader { geometry in
                VStack{
                    ZStack {
                        let width = geometry.size.width - self.marginLeading - self.marginTraling
                        ///main click with custom nidle to show in timers
                        ClockView(count: 240,
                                  longDevider: 4,
                                  longTickHeight: self.longTickHeight,
                                  tickHeight: self.tickHeight,
                                  tickwidth: self.tickWidth,
                                  highlightedColorDivider: 20
                                  ,highlightedColor:.clockhighlightedLineColor
                                  ,normalColor: .clocklineColor)
                            .frame(width: width,height: width)
                        
                        let miniWidth = width * 0.27
                        let miniExtraMarginFromBotton = width * 0.1
                        let miniPaddingBottom = miniWidth  + miniExtraMarginFromBotton
                        ///MiniClock  with custom nidle to show  timers
                        ClockView(count: 48,
                                  longDevider: 4,
                                  longTickHeight: self.miniLongTickHeight,
                                  tickHeight: self.miniTickHeight,
                                  tickwidth: self.tickWidth,
                                  highlightedColorDivider: 8
                                  ,highlightedColor:.clockhighlightedLineColor
                                  ,normalColor: .clocklineColor)
                            .frame(width: miniWidth,height: miniWidth)
                            .padding(.bottom,miniPaddingBottom)

                        
                        ///MiniClock  nidle show
                        let miniNumberWidth = miniWidth - self.miniNumberPadding
                        NumbersView(numbers: self.getNumbers(count: 6),font: .miniClockText,textColor: .clockTextColor)
                            .frame(width: miniNumberWidth,height: miniNumberWidth)
                            .padding(.bottom, miniPaddingBottom)
                        
                        
                        let numberWidth = width - self.numberPadding
                        NumbersView(numbers: self.getNumbers(count: 12),font: .clockText,textColor: .clockTextColor)
                            .frame(width: numberWidth,height: numberWidth)
                        
                        
                        Text (self.viewModel.totalforsettedTime)
                            .font(.LapText)
                            .foregroundColor(.clockTextColor)
                            .padding(.top, width * 0.39)
                        
                        
                        if self.viewModel.currentLapDegree != nil {
                            NeedleView(width: 8, height: width, color:.needleCurrentlap,bottomLineHeight: 30,filledCenter: false)
                                .rotationEffect(.radians(self.viewModel.currentLapDegree!))
                        }
                       
                        ///mainClock  Needle run with custom hight and colcors
                        
                        NeedleView(width: 8, height: width, color: .needleNormal, bottomLineHeight: 30, filledCenter: false)
                            .rotationEffect(.radians(self.viewModel.totalTimeDegree))
                        
                        ///MiniClock  Needle run with custom hight and colcors
                        NeedleView(width: 6, height: miniWidth, color: .needleNormal, filledCenter: true)
                            .rotationEffect(.radians(self.viewModel.totalTimeMinuteDegree))
                            .padding(.bottom, miniPaddingBottom)
                        
                        ///Custom Button with Start and lap Button With Action
                        HStack {
                            let leftButtonFeatures = self.getLeftButtonFeatures()
                            Button(leftButtonFeatures.0) {
                                self.viewModel.leftButtonTapped()
                            }.buttonStyle(ActionButtonStyle(textColor: leftButtonFeatures.1, backgroundColor: leftButtonFeatures.2))
                            Spacer()
                            let _: Color = self.viewModel.islapStarted ?.rightButtonActiveText : .rightButtonText
                            let rightButtonBackgroundColor: Color = self.viewModel.islapStarted ?.rightButtonActive : .rightButton
                            
                            
                            Button(self.viewModel.islapStarted ? "stop" : "Start") {
                                self.viewModel.rightButtonTapped()
                            }.buttonStyle(ActionButtonStyle(textColor: .rightButtonText, backgroundColor: rightButtonBackgroundColor))
                        }.padding(.top,width + self.actionButtonPadding)
                        
                    }
                    .padding(.leading,self.marginLeading)
                    .padding(.trailing,self.marginTraling)
                    .padding(.top,self.marginTop)
                    
                    ///List  of the lap with current runnin timers 
                    List {
                        ForEach(self.viewModel.presenters) { items in
                            VStack(alignment:.center,spacing: 0) {
                                Color.lapCellSeparator.frame(width: geometry.size.width,height:1)
                                HStack {
                                    let color = self.getLapTextColor(items.type)
                                    Text(items.lap)
                                        .foregroundColor(color)
                                        .font(.lapCellText)
                                    Spacer()
                                    Text(items.time)
                                        .foregroundColor(color)
                                        .font(.lapCellText)
                                }
                            }
                        }.listRowBackground(Color.backgroundColor)
                    }.listStyle(PlainListStyle())
                        .onAppear(perform:{
                            UITableView.appearance().backgroundColor = .clear
                            UITableViewCell.appearance().backgroundColor = .clear
                        })
                }
            }
        }
    }
    
    //MARK:- list Of number in Arraylist
    private func getNumbers(count:Int) -> [Int] {
        
        var numbers:[Int] = []
        numbers.append(count * 5)
        for index in 1..<count {
            numbers.append( index * 5)
        }
        return numbers
    }
    
    //MARK: - getLapTextColor
    private func getLapTextColor(_ type:lapType) -> Color {
        switch type {
        case .normal:
            return .lapCellNormal
        case .best:
            return .lapCellBest
        case .worst:
            return .lapCellworst
        }
    }
    
    //MARK: - getLeftButtonFeatures
    private func getLeftButtonFeatures() -> (String,Color,Color) {
        switch self.viewModel.isLeftBtnType {
        case.lapPassive :
            return ("Lap", .leftButtonText, .leftButton)
        case .lapActive:
            return ("Lap",.leftButtonActiveText, .leftButtonActive)
        case .reset:
            return ("Reset", .leftButtonActiveText, .leftButtonActive)
            
        }
    }
    
}

#Preview {
    ContentView()
}
