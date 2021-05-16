//
//  YoutubeVideoObject.swift
//  Embed Youtube Video
//
//  Created by Sinan on 16.05.2021.
//

import Foundation

class YoutubeVideoObject{
    var title : String
    var imageUrl : String
    var duration : String
    var videoId : String
    init(title : String, imageUrl : String, duration : String, videoId : String) {
        self.title = title
        self.imageUrl = imageUrl
        self.duration = duration
        self.videoId = videoId
    }
}


