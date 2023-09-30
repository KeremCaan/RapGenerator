//
//  SavedRaps.swift
//  NeonRapGenerator
//
//  Created by Kerem Caan on 2.09.2023.
//

import Foundation

class SavedRaps {

    var title: String
    let rapper: Int
    let song: String
    let backingtrack: String
    let bpm: Int

    init(title: String, rapper: Int, song: String, backingtrack: String, bpm: Int) {
        self.title = title
        self.rapper = rapper
        self.song = song
        self.backingtrack = backingtrack
        self.bpm = bpm
    }

}
