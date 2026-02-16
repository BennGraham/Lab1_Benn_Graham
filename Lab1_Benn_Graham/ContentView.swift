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
    
    var body: some View {
        VStack {
            Text("\(randomNumber)")
            
            Button {
                let answer = randomNumber.isPrime()
                isCorrect = answer
                randomNumber = Int.random(in: 1...1000)
            } label: {
                Text("Prime")
            }
            
            Button {
                let answer = randomNumber.isPrime()
                isCorrect = !answer
                randomNumber = Int.random(in: 1...1000)
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
