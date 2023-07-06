//
//  DiceView.swift
//  RollDice
//
//  Created by Rishav Gupta on 06/07/23.
//

import SwiftUI

struct DiceView: View {
    @EnvironmentObject var rolls: Rolls
    
    @State private var rolledNumber = 0
    @State private var noOfDice = 1
    @State private var diceFaces = 4
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedDices")
    
    @State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var counter = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Text("\(rolledNumber)")
                    .font(.system(size: 70))
                    .bold()
                
                Spacer()
                
                Stepper("No. of dice: \(noOfDice)", onIncrement: {
                    noOfDice += 1
                }, onDecrement: {
                    if noOfDice > 0 {
                        noOfDice -= 1
                    }
                })
                
                Stepper("Type of dice: \(diceFaces) sided", onIncrement: {
                    if diceFaces < 100 {
                        diceFaces += 1
                    }
                }, onDecrement: {
                    if diceFaces > 4 {
                        diceFaces -= 1
                    }
                })
                
                Button {
                    timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
                } label: {
                    Label("Let's Roll!", systemImage: "figure.dance")
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .background(.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
                .padding()
            }
            .navigationTitle("Roll Dice")
            .onReceive(timer) { time in
                if counter < 10 {
                    let maxLimit = noOfDice * diceFaces
                    rolledNumber = Int.random(in: noOfDice...maxLimit)
                } else {
                    counter = 0
                    timer.upstream.connect().cancel()
                    addRoll(rolledNumber: rolledNumber)
                }
                counter += 1
            }
            .onAppear(perform: disconnectTimer)
        }
    }
    
    func disconnectTimer() {
        timer.upstream.connect().cancel()
    }
    
    func addRoll(rolledNumber: Int) {
        let roll = Roll()
        roll.value = rolledNumber
        roll.quantity = noOfDice
        roll.type = diceFaces
        
        rolls.add(roll)
    }
}

#Preview {
    DiceView()
}
