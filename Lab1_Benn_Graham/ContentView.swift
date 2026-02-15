//
//  ContentView.swift
//  Lab1_Benn_Graham
//
//  Created by Benn Graham on 2026-02-15.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isCorrect: Bool? = nil
    
    var body: some View {
        VStack {
            Button {
                
            } label: {
                Text("Prime")
            }
            
            Button {
                
            } label: {
                Text("Not Prime")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
