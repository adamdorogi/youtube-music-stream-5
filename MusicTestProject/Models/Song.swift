//
//  Song.swift
//  MusicTestProject
//
//  Created by Adam Dorogi-Kaposi on 26/9/17.
//  Copyright © 2017 Adam Dorogi-Kaposi. All rights reserved.
//

import UIKit

/// Exception for JSON reading.
///
/// - missing: Missing key from JSON data dictionary.
enum SongSerializationError: Error {
    case missing(String)
}

/// A structure representing a song.
struct Song {
    let id: String
    let title: String
    let artistId: String
    let artistName: String
//    var audioUrl: URL
    var thumbnailUrl: URL // default, medium, high
    var releaseDate: Date
    
    /// Extract song details, and initialize structure.
    ///
    /// - Parameter json: JSON data of song.
    /// - Throws: SerializationError when cannot to extract information from JSON data.
    init(json: [String: Any]) throws {
        // Extract and validate ID.
        guard let ids = json["id"] as? [String: Any],
            let id = ids["videoId"] as? String else {
                throw SongSerializationError.missing("id")
        }
        
        // Extract and validate title.
        guard let result = json["snippet"]! as? [String: Any],
            let title = result["title"] as? String else {
                throw SongSerializationError.missing("title")
        }
        
        // Extract and validate channel ID.
        guard let artistId = result["channelId"] as? String else {
            throw SongSerializationError.missing("channelId")
        }
        
        // Extract and validate channel title.
        guard let artistName = result["channelTitle"] as? String else {
            throw SongSerializationError.missing("channelTitle")
        }
        
        // Extract and validate thumbnail URL.
        guard let thumbnails = result["thumbnails"] as? [String: Any],
            let thumbnailResolution = thumbnails["high"] as? [String: Any],
            let thumbnail = thumbnailResolution["url"] as? String,
            let thumbnailUrl = URL(string: thumbnail) else {
                throw SongSerializationError.missing("thumbnailUrl")
        }
        
        // Create date formatter.
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        // Extract and validate release date.
        guard let date = result["publishedAt"] as? String,
            let releaseDate = dateFormatter.date(from: date) else {
                throw SongSerializationError.missing("releaseDate")
        }
        
        // Initialize properties.
        self.id = id
        self.title = title
        self.artistId = artistId
        self.artistName = artistName
        self.thumbnailUrl = thumbnailUrl
        self.releaseDate = releaseDate
    }
    
//    func fetchAudioURL() throws {
//        // Read JSON audio info from URL.
//        let audioJSON = URL(string: "https://www.yt-mp3.com/fetch?v=\(self.id)&apikey=1234567")
//        let audioInfo = try ViewController().readJSON(url: audioJSON!)
//
//        self.audioURL = URL(string: "https:" + (audioInfo["url"] as! String))!
//    }
}