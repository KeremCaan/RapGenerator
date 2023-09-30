//
//  RapSongs.swift
//  NeonRapGenerator
//
//  Created by Kerem Caan on 29.08.2023.
//

import UIKit

struct RapSong: Codable {
    let voicemodelUUID: String


    enum CodingKeys: String, CodingKey {
        case voicemodelUUID = "voicemodel_uuid"

    }
}
typealias RapSongs = [RapSong]

struct RapperElement: Codable {
    let url: String
}

typealias Rapper = [RapperElement]
