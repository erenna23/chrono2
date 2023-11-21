//
//  ContentView.swift
//  chrono2
//
//  Created by Eugenio Renna on 13/11/23.
//
import SwiftUI

struct ContentView: View {
    @State private var elapsedTime: TimeInterval = 0
    @State private var isRunning = false
    @State private var timer: Timer?
    @State private var lapTimes: [TimeInterval] = []

    var body: some View {
        VStack {
            Text(formatTime(elapsedTime))
                .font(.custom("", size: 80))
                .fontWeight(.light)

            HStack(spacing: 80) {
                Button(action: {
                    if self.isRunning {
                        self.stopTimer()
                    } else {
                        self.startTimer()
                    }
                }) {
                    Text(self.isRunning ? "Stop" : "Start")
                        .padding()
                        .frame(width: 75, height: 70)
                        .background(Color.green)
                        .foregroundColor(Color.white)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                }

                Button(action: {
                    self.resetTimer()
                }) {
                    Text("Reset")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .padding()
                        .frame(width: 75, height: 70)
                        .background(Color.gray)
                        .foregroundColor(Color.white)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                }

                Button(action: {
                    self.addLap()
                }) {
                    Text("Lap")
                        .padding()
                        .frame(width: 75, height: 70)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                }
            }

            List {
                ForEach(0..<lapTimes.count, id: \.self) { index in
                    Text("Lap \(index + 1): \(formatTime(self.lapTimes[index]))")
                }
            }
            .frame(maxHeight: 300)
        }
        .padding()
    }

    private func startTimer() {
        self.isRunning = true
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            self.elapsedTime += 0.1
        }
    }

    private func stopTimer() {
        self.isRunning = false
        self.timer?.invalidate()
        self.timer = nil
    }

    private func resetTimer() {
        self.stopTimer()
        self.elapsedTime = 0
        self.lapTimes.removeAll()
    }

    private func addLap() {
        self.lapTimes.append(self.elapsedTime)
    }

    private func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        let tenths = Int((time.truncatingRemainder(dividingBy: 1)) * 10)

        return String(format: "%02d:%02d.%d", minutes, seconds, tenths)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.device)
    }
}
