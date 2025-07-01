//
//  ContentView.swift
//  Stopwatch_swiftui
//
//  Created by 深野真人 on 2025/06/26.
//
import SwiftUI

struct ContentView: View {
    @State private var timer: Timer!
    @State private var secondsElapsed: Double = 0.0
    @State private var isRunning = false
    @State private var laps: [Double] = []

    var body: some View {
        VStack(spacing: 20) {
            Text(String(format: "%.2f", secondsElapsed))
                .font(.largeTitle)

            HStack(spacing: 20) {
                if isRunning {
                    Button(action: pause) {
                        Image(systemName: "pause.fill")
                            .foregroundColor(.white)
                            .font(.title)
                            .padding()
                            .background(Color.red)
                            .clipShape(Circle())
                    }

                    Button(action: recordLap) {
                        Image(systemName: "flag.fill")
                            .foregroundColor(.white)
                            .font(.title)
                            .padding()
                            .background(Color.blue)
                            .clipShape(Circle())
                    }

                } else {
                    Button(action: start) {
                        Image(systemName: "play.fill")
                            .foregroundColor(.white)
                            .font(.title)
                            .padding()
                            .background(Color.green)
                            .clipShape(Circle())
                    }
                }

                if secondsElapsed != 0.0 {
                    Button(action: stop) {
                        Image(systemName: "stop.fill")
                            .foregroundColor(.white)
                            .font(.title)
                            .padding()
                            .background(Color.gray)
                            .clipShape(Circle())
                    }
                }
            }

            if !laps.isEmpty {
                List {
                    ForEach(Array(laps.enumerated()), id: \.offset) { index, lap in
                        Text("Lap \(laps.count - index): \(String(format: "%.2f", lap)) 秒")
                    }
                }
                .frame(height: 600)
            }

            Spacer()
        }
        .padding()
    }

    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            secondsElapsed += 0.1
        }
        isRunning = true
    }

    func pause() {
        timer.invalidate()
        isRunning = false
    }

    func stop() {
        timer.invalidate()
        isRunning = false
        secondsElapsed = 0.0
        laps.removeAll()
    }

    func recordLap() {
        laps.insert(secondsElapsed, at: 0)
    }
}

#Preview {
    ContentView()
}
