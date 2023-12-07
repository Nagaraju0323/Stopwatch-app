import SwiftUI

struct DigitalView: View {
    @State private var elapsedTime: TimeInterval = 0
    @State private var isRunning = false
    @State private var timer: Timer?
    @State private var lapTimes: [String] = []
    @State private var textSize: CGSize = .zero

    var body: some View {
        ZStack {
            Color.backgroundColor.ignoresSafeArea(.all)
            VStack {
                Text("\(formattedTime(elapsedTime))").foregroundColor(.white)
                    .font(.system(size: 80))
                    .padding()
                    .minimumScaleFactor(1.0)

                HStack {
                    Spacer()
                    
                    circleButton(action: {
                        self.lap()
                    }, label: "Lap", color: .orange)
                    .disabled(!isRunning)
                    
                    Spacer()
                    
                    circleButton(action: {
                        self.startStopwatch()
                    }, label: isRunning ? "Stop" : "Start", color: isRunning ? .red : .green)
                    
                    Spacer()
                    
                    circleButton(action: {
                        self.resetStopwatch()
                    }, label: "Reset", color: .blue)
                    
                    Spacer()
                }
                .padding()
                
                List {
                    ForEach(lapTimes.indices, id: \.self) { index in
                        Text("Lap \(index + 1): \(lapTimes[index])")
                            .foregroundColor(.lapCellBest)
                            .font(.lapCellText)
                    }
                    .listRowBackground(Color.backgroundColor)
                }
                .listStyle(PlainListStyle())
                .onAppear {
                    UITableView.appearance().backgroundColor = .clear
                    UITableViewCell.appearance().backgroundColor = .clear
                }
                .padding()
            }
        }
    }

    //MARK: Custom the circle button
    func circleButton(action: @escaping () -> Void, label: String, color: Color) -> some View {
        Button(action: action) {
            Text(label)
                .foregroundColor(.white)
                .padding()
                .frame(width: 80, height: 80)
                .background(color)
                .clipShape(Circle())
        }
    }
    //MARK: - startStopwatch
    func startStopwatch() {
        if isRunning {
            timer?.invalidate()
        } else {
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                self.elapsedTime += 0.1
            }
        }

        isRunning.toggle()
    }
    //MARK: - resetStopwatch
    func resetStopwatch() {
        timer?.invalidate()
        elapsedTime = 0
        isRunning = false
        lapTimes.removeAll()
    }

    //MARK: - append to every lap
    func lap() {
        let lapTime = formattedTime(elapsedTime)
        lapTimes.append(lapTime)
    }

    //MARK: - Set the time format 
    func formattedTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        let tenths = Int((time.truncatingRemainder(dividingBy: 1)) * 60)

        return String(format: "%02d:%02d.%02d", minutes, seconds, tenths)
    }
}



#Preview {
        DigitalView()
    }

