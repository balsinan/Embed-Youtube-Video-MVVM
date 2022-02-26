//
//  VideoDurationModel.swift
//  Embed Youtube Video
//
//  Created by Sinan on 17.05.2021.
//

import Foundation

// MARK: - YoutubeVideoModel
class VideoDurationModel: Codable {
    let kind, etag: String
    let items: [DuraitonItem]

    init(kind: String, etag: String, items: [DuraitonItem]) {
        self.kind = kind
        self.etag = etag
        self.items = items
       
    }
}

// MARK: - Item
class DuraitonItem: Codable {
    let kind, etag, id: String
    let contentDetails: ContentDetails

    init(kind: String, etag: String, id: String, contentDetails: ContentDetails) {
        self.kind = kind
        self.etag = etag
        self.id = id
        self.contentDetails = contentDetails
    }
}

// MARK: - ContentDetails
class ContentDetails: Codable {
    let duration, dimension, definition, caption: String
    let licensedContent: Bool
    let contentRating: ContentRating
    let projection: String

    init(duration: String, dimension: String, definition: String, caption: String, licensedContent: Bool, contentRating: ContentRating, projection: String) {
        self.duration = duration
        self.dimension = dimension
        self.definition = definition
        self.caption = caption
        self.licensedContent = licensedContent
        self.contentRating = contentRating
        self.projection = projection
    }
}

// MARK: - ContentRating
class ContentRating: Codable {

    init() { }
}

