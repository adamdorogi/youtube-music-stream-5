//
//  Artist.swift
//  MusicTestProject
//
//  Created by Adam Dorogi-Kaposi on 26/9/17.
//  Copyright © 2017 Adam Dorogi-Kaposi. All rights reserved.
//

import UIKit


/// Exception for JSON reading.
///
/// - missing: Missing key from JSON data dictionary.
enum ArtistSerializationError: Error {
    case missing(String)
}

/// A structure representing an artist.
struct Artist {
    let id: String
    let name: String
    let thumbnailUrl: URL // default, medium, high
    
    
    /// Extract artist details, and initialize structure.
    ///
    /// - Parameter json: JSON data of artist.
    /// - Throws: SerializationError when cannot to extract information from JSON data.
    init(json: [String: Any]) throws {
        // Extract and validate ID.
        guard let ids = json["id"] as? [String: Any],
            let id = ids["channelId"] as? String else {
                throw ArtistSerializationError.missing("id")
        }
        
        // Extract and validate name.
        guard let result = json["snippet"]! as? [String: Any],
            let name = result["title"] as? String else {
                throw ArtistSerializationError.missing("name")
        }
        
        // Extract and validate thumbnail URL.
        guard let thumbnails = result["thumbnails"] as? [String: Any],
            let thumbnailResolution = thumbnails["high"] as? [String: Any],
            let thumbnail = thumbnailResolution["url"] as? String,
            let thumbnailUrl = URL(string: thumbnail) else {
                throw ArtistSerializationError.missing("thumbnailUrl")
        }
        
        // Initialize properties.
        self.id = id
        self.name = name
        self.thumbnailUrl = thumbnailUrl
    }
}
