//
//  ViewModel.swift
//  IOSClockApp
//
//  Created by Nagaraju on 06/12/23.
//

import Foundation

class ViewModel : ObservableObject {
    
    @Published var presenters:[LapItemPresenter]  = []
    @Published var totalforsettedTime: String = ""
    @Published var islapStarted: Bool = false
    @Published var isLeftBtnType:LeftButtonType = .lapPassive
    @Published var totalTimeDegree: Double = 0
    @Published var currentLapDegree: Double?
    @Published var totalTimeMinuteDegree:Double = 0
    
    private var startDate:Date?
    private var timer : Timer?
    private var lapIndex: Int = 0
    private var lapTimes: [Double] = []
    private var totalTimeElapsed:Double = 0
    
    init() {
        resetView()
        
    }
///Reight button - Start and stop Action Perform
    func rightButtonTapped() {
        if self.islapStarted{
            self.updatetimes()
            self.timer?.invalidate()
            self.isLeftBtnType = .reset
            
        }else {
            self.startDate = Date()
            self.updatePresenters()
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: {  [weak self] (_) in
                self?.updateCurrentLapTime()
            })
            self.isLeftBtnType = .lapActive
            
        }
        self.islapStarted.toggle()
       
    }
    
    ///Left Button - Lap action  and Reset Action perfrom
    func leftButtonTapped() {

        switch isLeftBtnType {
        case .lapPassive :
            ()
        case .lapActive:
            self.updatetimes()
            self.lapTimes.append(0)
            self.lapIndex += 1
            self.startDate = Date()
            self.updatePresenters()
        case .reset:
            self.resetView()
        }
    }
    
    ///Reset - reset all the current  timers make it start postion
    private func resetView() {
        self.isLeftBtnType = .lapPassive
        self.presenters = []
        self.lapTimes = []
        self.lapIndex = 0
        self.lapTimes.append(0)
        self.totalforsettedTime = self.getFormattedstring(0)
        self.totalTimeElapsed = 0
        self.totalTimeDegree = 0
        self.currentLapDegree = nil
    }
    
    ///updatetimes -  it can upate the times total time and get timesers
    private func updatetimes(){
    let timElapsed = self.getTimeElapsed()
    self.totalTimeElapsed += timElapsed
    self.lapTimes[lapIndex] += timElapsed
                                
    }
   
    //MARK:-  updateCurrentLapTime
    ///when tap the lap button keep update the timeer
    private func updateCurrentLapTime() {
        
        var timeElapsed : TimeInterval = 0
        var lapTimeElapsed:TimeInterval = 0
        if startDate != nil {
            lapTimeElapsed = self.getTimeElapsed() + lapTimes[self.lapIndex]
            timeElapsed = getTimeElapsed() + self.totalTimeElapsed
            if timeElapsed != 0 {
                self.totalTimeDegree = Double.pi * Double(timeElapsed) / 30
                self.totalTimeMinuteDegree = Double.pi * Double(timeElapsed) / 900
            }
            if lapTimeElapsed != 0 {
                self.currentLapDegree = Double.pi * Double(lapTimeElapsed) / 30
            }
        }

        self.totalforsettedTime = self.getFormattedstring(timeElapsed)
        self.presenters[0].time = self.getFormattedstring(lapTimeElapsed)
        
    }
    
    //MARK: - getTimeElapsed
    
    private func getTimeElapsed() -> Double {
        return Date().timeIntervalSince1970  - self.startDate!.timeIntervalSince1970
    }
    
    private func getFormattedstring(_ timElapsed: Double) -> String {
        var timeElapsed = timElapsed
        
        let minutes :Int = Int(timeElapsed / 60)
        timeElapsed -= (Double (minutes) * 60)
        let seconds:Int = Int(timeElapsed)
        timeElapsed -= Double(seconds)
        let milliseconds = Int(timeElapsed * 100)
       return String(format:"%02d:%02d, %002d", minutes, seconds, milliseconds)
        
    }
    
    //MARK: - UpdatePresenters
    ///based  lap times if mininux and maximux timesing
    ///it will show  on it update if want reset postion and start again
    private func updatePresenters() {
        
        self.presenters = []
        for(index,lap) in self.lapTimes.enumerated() {
            self.presenters.append(LapItemPresenter(lap: "Lap \(index + 1)",time: self.getFormattedstring(lap),type: .normal))
        }
        var times = self.lapTimes
        times.removeLast()
        if times.count > 1 {
            var minIndex = 0
            var maxIndex = 0
            for(index,time) in times.enumerated() {
                if time < times[minIndex] {
                    minIndex = index
                }
                if time > times[maxIndex] {
                    maxIndex = index
                }
            }
            self.presenters[minIndex].type = .best
            self.presenters[maxIndex].type = .worst
            
        }
        self.presenters.reverse()
    }
    
}
