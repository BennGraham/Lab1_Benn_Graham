//
//  ContentView.swift
//  Lab1_Benn_Graham
//
//  Created by Benn Graham on 2026-02-15.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isCorrect: Bool? = nil
    @State private var randomNumber: Int = Int.random(in: 1...1000)
    @State private var attempts: [(number: Int, guess: String, correct: Bool)] = []
    @State private var showDialog: Bool = false
    
    var body: some View {
        VStack {
            Text("\(randomNumber)")
            
            Button {
                let answer = randomNumber.isPrime()
                isCorrect = answer
                attempts.append((number: randomNumber, guess: "Prime", correct: answer))
                if attempts.count >= 10 {
                    showDialog = true
                } else {
                    randomNumber = Int.random(in: 1...1000)
                }
            } label: {
                Text("Prime")
            }
            
            Button {
                let answer = randomNumber.isPrime()
                isCorrect = !answer
                attempts.append((number: randomNumber, guess: "Not Prime", correct: !answer))
                if attempts.count >= 10 {
                    showDialog = true
                } else {
                    randomNumber = Int.random(in: 1...1000)
                }
            } label: {
                Text("Not Prime")
            }
            
            if let correct = isCorrect {
                Image(systemName: correct ? "checkmark" : "xmark")
                    .font(.system(size: 60))
                    .foregroundColor(correct ? .green : .red)
            }
        }
        .padding()
        .alert("Results", isPresented: $showDialog) {
            Button("Try Again") {
                attempts = []
                isCorrect = nil
                randomNumber = Int.random(in: 1...1000)
            }
        } message: {
            let history = attempts.map { "\($0.number): \($0.guess) \($0.correct ? "✓" : "✗")" }.joined(separator: "\n")
            let correctCount = attempts.filter { $0.correct }.count
            let wrongCount = attempts.filter { !$0.correct }.count
            Text("\(history)\n\nCorrect: \(correctCount) | Incorrect: \(wrongCount)")
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
