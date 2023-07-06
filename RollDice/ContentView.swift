//
//  ContentView.swift
//  RollDice
//
//  Created by Rishav Gupta on 06/07/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var rolls = Rolls()
    
    var body: some View {
        TabView {
            DiceView()
                .tabItem{
                    Label("Roll Dice", systemImage: "gamecontroller.fill")
                }
            
            HistoryView()
                .tabItem{
                    Label("History", systemImage: "clock")
                }
        }
        .environmentObject(rolls)
    }
}

#Preview {
    ContentView()
}
