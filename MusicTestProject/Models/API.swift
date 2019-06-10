//
//  API.swift
//  MusicTestProject
//
//  Created by Adam Dorogi-Kaposi on 29/9/17.
//  Copyright © 2017 Adam Dorogi-Kaposi. All rights reserved.
//

struct API {
    // YouTube API key.
    static let key = "AIzaSyBvpV3r2SIp-B3KH5Hz736P4SYeEUK0AO8"
    
    // YouTube single video API request (Videos: list).
    static let video = "https://www.googleapis.com/youtube/v3/videos?part=snippet&id=%@&key=\(key)"
    
    // YouTube single channel API request (Channels: list).
    static let channel = "https://www.googleapis.com/youtube/v3/channels?part=snippet%%2Cstatistics&id=%@&key=\(key)"
    
    // YouTube video search API request (Search: list).
    static let videoSearch = "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=%d&q=%@&type=video&videoCategoryId=10&key=\(key)"

    // YouTube channel search API request (Search: list).
    static let channelSearch = "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=%d&q=%@&type=channel&key=\(key)"
    
    // YouTube video search by channel API request (Search: list).
    static let channelVideoSearch = "https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=%@&maxResults=%d&type=video&videoCategoryId=10&key=\(key)"
}
