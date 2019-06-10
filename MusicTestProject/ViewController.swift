//
//  ViewController.swift
//  MusicTestProject
//
//  Created by Adam Dorogi-Kaposi on 23/9/17.
//  Copyright © 2017 Adam Dorogi-Kaposi. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    // Stored propertios of ViewController (must either have value, or be optional)
    var player: AVPlayer?
    var playerItem: AVPlayerItem?
    var url: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        do {
//            let song = try Song(id: "yzTuBuRdAyA")
//            print("SONG ID:       " + song.id)
//            print("SONG TITLE:    " + song.title)
////            print("AUDIO URL:     " + "\(song.audioURL)")
//            print("THUMBNAIL URL: " + "\(song.thumbnailURL)")
//            print("RELEASE DATE:  " + "\(song.releaseDate)")
////            print("DURATION:      " + "\(song.duration)")
//            print("ARTIST ID:     " + song.artist.id)
//            print("ARTIST NAME:   " + song.artist.name)
//            print("ARTIST PIC:    " + "\(song.artist.thumbnailURL)")
//
////            playSong(url: song.audioURL)
//        } catch {
//            print(error.localizedDescription)
//        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    /// Play a song from given URL.
    ///
    /// - Parameter url: The audio file URL.
    func playSong(url: URL) {
        // TODO: explore AVPlayerItem and AVPlayer
        self.playerItem = AVPlayerItem(url: url)
        self.player = AVPlayer(playerItem: playerItem)
        
        self.player!.automaticallyWaitsToMinimizeStalling = false
        self.player?.play()
    }
    
    /// Read JSON data from given URL, return a dictionary of the downloaded JSON data.
    ///
    /// - Parameter url: The JSON file URL.
    /// - Returns: Dictionary of JSON data.
    func readJSON(url: URL) throws -> [String: Any] {
        var jsonData: Data
        var jsonDictionary: [String: Any]
        
        do {
            // Read JSON data from URL.
            try jsonData = Data(contentsOf: url, options: NSData.ReadingOptions())
        } catch {
            throw APIError.noData
        }
        
        do {
            // Create dictionary of JSON data.
            try jsonDictionary = JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions()) as! [String: Any]
        } catch {
            throw APIError.JSONSerialization(error: error)
        }
        
        return jsonDictionary
    }
    
    /// Exceptions for APIs.
    ///
    /// - noData: No data received from the server.
    /// - JSONSerialization: Cannot convert JSON to Dictionary.
    enum APIError: Error {
        case noData
        case JSONSerialization(error: Error)
    }
}

