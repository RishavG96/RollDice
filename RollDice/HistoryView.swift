//
//  HistoryView.swift
//  RollDice
//
//  Created by Rishav Gupta on 06/07/23.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var rolls: Rolls
    
    var body: some View {
        NavigationView {
            List {
                ForEach(rolls.dice) { roll in
                    HStack {
                        Text("Rolled \(roll.value)")
                            .foregroundColor(.orange)
                            .font(.title3)
                            .bold()
                            .padding(.vertical)
                        
                        Text("\(roll.type) sides + \(roll.quantity) dices")
                            .foregroundColor(.white)
                            .font(.title3)
                            .bold()
                            .padding(.vertical)
                            .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("History")
        }
    }
}

#Preview {
    HistoryView()
}
