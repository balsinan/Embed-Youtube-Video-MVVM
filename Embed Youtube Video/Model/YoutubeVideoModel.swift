//
//  YoutubeVideoModel.swift
//  Embed Youtube Video
//
//  Created by Sinan on 17.05.2021.
//

import Foundation

// MARK: - YoutubeVideoModel
class YoutubeVideoModel: Codable {
    let kind, etag: String?
    let items: [Item]
    let pageInfo: PageInfo?
 
}

// MARK: - Item
class Item: Codable {
    let kind, etag, id: String
    let snippet: Snippet
}

// MARK: - Snippet
class Snippet: Codable {
    let publishedAt: String
    let channelID, title, snippetDescription: String
    let thumbnails: Thumbnails
    let channelTitle, playlistID: String
    let position: Int
    let resourceID: ResourceID

    enum CodingKeys: String, CodingKey {
        case publishedAt
        case channelID = "channelId"
        case title
        case snippetDescription = "description"
        case thumbnails, channelTitle
        case playlistID = "playlistId"
        case position
        case resourceID = "resourceId"
    }
 
}

// MARK: - ResourceID
class ResourceID: Codable {
    let kind, videoID: String

    enum CodingKeys: String, CodingKey {
        case kind
        case videoID = "videoId"
    }
 
}

// MARK: - Thumbnails
class Thumbnails: Codable {
    let thumbnailsDefault, medium, high, standard: Default
//    let maxres: Default

    enum CodingKeys: String, CodingKey {
        case thumbnailsDefault = "default"
        case medium, high, standard//, maxres
    }
 
}

// MARK: - Default
class Default: Codable {
    let url: String
    let width, height: Int
 
}

// MARK: - PageInfo
class PageInfo: Codable {
    let totalResults, resultsPerPage: Int
 
}
