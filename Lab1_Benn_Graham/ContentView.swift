// COMP3097 Lab Test 1
//  ContentView.swift
//  Lab1_Benn_Graham
//
//  Created by Benn Graham - 101412278 on 2026-02-15.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isCorrect: Bool? = nil
    @State private var randomNumber: Int? = nil
    @State private var attempts: [(number: Int, guess: String, correct: Bool)] = []
    @State private var showDialog: Bool = false
    @State private var timeLeft: Double = 5.0
    @State private var timer: Timer? = nil
    
    var body: some View {
        VStack {
            if let number = randomNumber {
                Text(String(number))
                    .font(.system(size: 90, weight: .bold))
                    .frame(height: 120)
            } else {
                Text("Press Start to Begin")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.gray)
                    .frame(height: 120)
            }
            
            Spacer()
            
            if randomNumber != nil {
                ProgressView(value: Double(timeLeft), total: 5.0)
                    .scaleEffect(y: 3)
                    .frame(height: 12)
                    .background(Color.gray.opacity(0.2))
                    .tint(timeLeft <= 1 ? .red : timeLeft <= 2 ? .orange : .blue)
                    .padding(.horizontal, 0)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            }
        
            Button {
                guard let currentNumber = randomNumber else { return }
                let answer = currentNumber.isPrime()
                isCorrect = answer
                attempts.append((number: currentNumber, guess: "Prime", correct: answer))
                if attempts.count >= 10 {
                    timer?.invalidate()
                    timer = nil
                    showDialog = true
                } else {
                    randomNumber = Int.random(in: 1...1000)
                    startTimer()
                }
            } label: {
                Text("Prime")
                    .font(.system(size: 36, weight: .semibold))
                    .padding(.horizontal, 50)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .background(.green)
                    .foregroundColor(.white)
                    .cornerRadius(16)
            }
            .disabled(randomNumber == nil)
            .opacity(randomNumber == nil ? 0.4 : 1.0)
            
            Button {
                guard let currentNumber = randomNumber else { return }
                let answer = currentNumber.isPrime()
                isCorrect = !answer
                attempts.append((number: currentNumber, guess: "Not Prime", correct: !answer))
                if attempts.count >= 10 {
                    timer?.invalidate()
                    timer = nil
                    showDialog = true
                } else {
                    randomNumber = Int.random(in: 1...1000)
                    startTimer()
                }
            } label: {
                Text("Not Prime")
                    .font(.system(size: 36, weight: .semibold))
                    .padding(.horizontal, 50)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .background(.red)
                    .foregroundColor(.white)
                    .cornerRadius(16)
            }
            .disabled(randomNumber == nil)
            .opacity(randomNumber == nil ? 0.4 : 1.0)
            
            Spacer()
            
            if let correct = isCorrect {
                Image(systemName: correct ? "checkmark" : "xmark")
                    .font(.system(size: 72))
                    .foregroundColor(correct ? .green : .red)
            } else {
                Button {
                    randomNumber = Int.random(in: 1...1000)
                    startTimer()
                } label: {
                    Text("Start")
                        .font(.system(size: 36, weight: .semibold))
                        .padding(.horizontal, 50)
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(16)
                }
            }
        }
        .padding()
        .alert("Results", isPresented: $showDialog) {
            Button("Try Again") {
                attempts = []
                isCorrect = nil
                randomNumber = nil
                timer?.invalidate()
                timer = nil
                timeLeft = 5
            }
        } message: {
            let history = attempts.map { "\($0.number): \($0.guess) \($0.correct ? "✓" : "✗")" }.joined(separator: "\n")
            let correctCount = attempts.filter { $0.correct }.count
            let wrongCount = attempts.filter { !$0.correct }.count
            Text("\(history)\n\nCorrect: \(correctCount) | Incorrect: \(wrongCount)")
        }
    }
    
    func startTimer() {
        timer?.invalidate()
        timeLeft = 5
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            if timeLeft > 0 {
                timeLeft -= 0.05
            } else {
                guard let number = randomNumber else { return }
                timer?.invalidate()
                timer = nil
                isCorrect = false
                attempts.append((number: number, guess: "No Answer", correct: false))
                if attempts.count >= 10 {
                    showDialog = true
                } else {
                    randomNumber = Int.random(in: 1...1000)
                    startTimer()
                }
            }
        }
    }
}

extension Int {
    func isPrime() -> Bool {
        if self <= 1 { return false }
        if self == 2 { return true }
    
        for i in 2...Int(Double(self).squareRoot()) {
            if self % i == 0 { return false }
        }
        
        return true
    }
}

#Preview {
    ContentView()
}
