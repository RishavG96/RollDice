//
//  Dice.swift
//  RollDice
//
//  Created by Rishav Gupta on 06/07/23.
//

import Foundation

class Roll: Identifiable, Codable {
    var id = UUID()
    var value = 0
    var quantity = 0
    var type = 4
    var date: Date = Date.now
}

@MainActor class Rolls: ObservableObject {
    @Published private(set) var dice: [Roll]
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedDices")
    
    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode([Roll].self, from: data) {
                dice = decoded
                return
            }
        }
        dice = []
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(dice) {
            try? encoded.write(to: savePath, options: [.atomic, .completeFileProtection])
        }
    }
    
    func add(_ roll: Roll) {
        dice.append(roll)
        save()
    }
}
