//
//  SearchTableViewController.swift
//  MusicTestProject
//
//  Created by Adam Dorogi-Kaposi on 29/9/17.
//  Copyright © 2017 Adam Dorogi-Kaposi. All rights reserved.
//

import UIKit

/// Represents a section in a table view, with a title, and results.
struct Section {
    var title: String
    var results: [Any]
}

/// Handles the API search for Songs and Artists.
class SearchTableViewController: UITableViewController, UISearchBarDelegate{
    // Section titles.
    var headerTitles: [String] = ["Songs", "Artists"]
    
    // Search results.
    var songSearchResults: [Song] = []
    var artistSearchResults: [Artist] = []
    var searchResults: [Section] = []
    
    // Search task.
    var searchRequest: DispatchWorkItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Enable large titles.
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Setup search bar.
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.barStyle = .black
        searchController.searchBar.delegate = self
        searchController.searchBar.keyboardAppearance = .dark
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        // Setup table view.
        tableView.backgroundColor = .background
        tableView.separatorColor = tableView.backgroundColor
        
        // Setup cells.
        tableView.register(SongTableViewCell.self, forCellReuseIdentifier: "song")
        tableView.register(ArtistTableViewCell.self, forCellReuseIdentifier: "artist")
    }

    // MARK: - Table view data source

    /// Sets the number of sections in the current table view.
    ///
    /// - Parameter tableView: Table view to set number of sections for.
    /// - Returns: Number of sections to set for table view.
    override func numberOfSections(in tableView: UITableView) -> Int {
        return searchResults.count
    }

    /// Sets the number of rows in each section in the current table view.
    ///
    /// - Parameters:
    ///   - tableView: Table view to set number of rows in section for.
    ///   - section: Section to set number of rows for.
    /// - Returns: Number of rows to set for each section in the table view.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults[section].results.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchResults[indexPath.section].title == headerTitles[0] {
//            performSegue(withIdentifier: "showPlayer", sender: self)
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
//        let songTitle = songSearchResults[indexPath.row].title
//        (tabBarController as! PlayerBarController).playerBar.setTitle(title: songTitle)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if searchResults[indexPath.section].title == headerTitles[0] { // Song section.
            // Create song cell.
            let songCell = tableView.dequeueReusableCell(withIdentifier: "song", for: indexPath) as! SongTableViewCell
            
            // Get song for current cell.
            let song = searchResults[indexPath.section].results[indexPath.row] as! Song
            
            // Update song cell labels.
            songCell.titleLabel.text = song.title
            songCell.artistLabel.text = song.artistName
            
            return songCell
        } else { // Artist section.
            // Create artist cell.
            let artistCell = tableView.dequeueReusableCell(withIdentifier: "artist", for: indexPath) as! ArtistTableViewCell
            
            // Get artist for current cell.
            let artist = searchResults[indexPath.section].results[indexPath.row] as! Artist

            // Update artist cell label.
            artistCell.nameLabel.text = artist.name
            
            // Set place holder image.
            artistCell.profileImageView.image = UIImage(named: "artist.pdf")

            DispatchQueue.global().async { // Background process.
                do {
                    // Download artist profile image data.
                    let profileImageData = try Data(contentsOf: artist.thumbnailUrl)
                    
                    DispatchQueue.main.async { // After background process.
                        // Update artist profile image.
                        artistCell.profileImageView.image = UIImage(data: profileImageData)
                    }
                } catch { // Couldn't download artist profile image.
                    print("ERROR: Couldn't download artist profile image.")
                }
            }

            return artistCell
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return searchResults[section].title
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if searchResults[indexPath.section].title == headerTitles[0] {
            return (tableView.dequeueReusableCell(withIdentifier: "song")?.bounds.height)!
        } else if searchResults[indexPath.section].title == headerTitles[1] {
            return (tableView.dequeueReusableCell(withIdentifier: "artist")?.bounds.height)!
        }
        
        return 0
    }
    
    /// Update search results everytime the text in the search bar changes.
    ///
    /// - Parameters:
    ///   - searchBar: The search bar in which the text is entered.
    ///   - searchText: The text which is entered in the search bar.
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Maximum number of results to display.
        let maxResults = 5
        
        // Cancel the search request.
        searchRequest?.cancel()
        
        searchRequest = DispatchWorkItem {
            // Clear search result sections.
            self.searchResults.removeAll()
            
            // URL encode search text.
            let urlQuery = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            
            // Get URL of JSON data.
            let videoSearchJSON = URL(string: String(format: API.videoSearch, maxResults, urlQuery))
            let channelSearchJSON = URL(string: String(format: API.channelSearch, maxResults, urlQuery))

            DispatchQueue.global().async {
                do {
                    // Read JSON data from URL.
                    let videoSearchResults = try self.readJson(url: videoSearchJSON!)["items"] as! [[String: Any]]
                    let channelSearchResults = try self.readJson(url: channelSearchJSON!)["items"] as! [[String: Any]]
                    
                    // Clear search results.
                    self.songSearchResults.removeAll()
                    self.artistSearchResults.removeAll()
                
                    // For each video result, initialize a Song,
                    // and add it to the song search results.
                    for videoSearchResult in videoSearchResults {
                        let song = try Song(json: videoSearchResult)
                        self.songSearchResults.append(song)
                    }
                    
                    // For each channel result, initialize an Artist,
                    // and add it to the artist search results.
                    for channelSearchResult in channelSearchResults {
                        let artist = try Artist(json: channelSearchResult)
                        self.artistSearchResults.append(artist)
                    }
                
                    // Create section for the song results.
                    if !self.songSearchResults.isEmpty {
                        self.searchResults.append(Section(title: self.headerTitles[0], results: self.songSearchResults))
                    }

                    // Create section for the artist results.
                    if !self.artistSearchResults.isEmpty {
                        self.searchResults.append(Section(title: self.headerTitles[1], results: self.artistSearchResults))
                    }
                } catch {
                    print(error)
                    return
                }
                
                // Background processes have finished.
                DispatchQueue.main.async {
                    // Reload the table view.
                    self.tableView.reloadData()
                }
            }
        }
        
        // Execute the search request after certain period of time.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: searchRequest!)
    }
    
    /// Read JSON data from given URL, return a dictionary of the downloaded JSON data.
    ///
    /// - Parameter url: The JSON file URL.
    /// - Returns: Dictionary of JSON data.
    func readJson(url: URL) throws -> [String: Any] {
        // Read JSON data from URL.
        let data = try Data(contentsOf: url)
        // Create dictionary of JSON data.
        let json = try JSONSerialization.jsonObject(with: data) as! [String: Any]
        
        return json
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPlayer" {
            let player = segue.destination as! PlayerViewController
            let indexPath = tableView.indexPathForSelectedRow
            
            player.song = songSearchResults[(indexPath?.row)!]
        }
    }
}
