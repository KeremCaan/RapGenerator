//
//  Beats.swift
//  NeonRapGenerator
//
//  Created by Kerem Caan on 30.08.2023.
//

import UIKit

struct Beats: Codable {
    let backingTracks: [BackingTracks]

    enum CodingKeys: String, CodingKey {
        case backingTracks = "backing_tracks"
    }
}

struct BackingTracks: Codable {
    let bpm: Int
    let uuid, name: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case bpm, uuid, name
        case url
    }
}

struct BeatURL: Codable {
    let mixURL, vocalsURL: String

    enum CodingKeys: String, CodingKey {
        case mixURL = "mix_url"
        case vocalsURL = "vocals_url"
    }
}
