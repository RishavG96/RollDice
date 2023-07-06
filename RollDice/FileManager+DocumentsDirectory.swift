//
//  FileManager+DocumentsDirectory.swift
//  RollDice
//
//  Created by Rishav Gupta on 06/07/23.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
