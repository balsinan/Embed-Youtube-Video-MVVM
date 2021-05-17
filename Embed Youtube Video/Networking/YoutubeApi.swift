//
//  YoutubeApi.swift
//  Embed Youtube Video
//
//  Created by Sinan on 17.05.2021.
//

import Foundation
import Alamofire

let YoutubePlaylistApi = "https://www.googleapis.com/youtube/v3/playlistItems"

class YoutubeApi{
    static let sharedInstance = YoutubeApi()
    public typealias onCompleteVideoHandler = (([YoutubeVideoObject]?,AFError?)->())
    
    
    func fetchChannelVideoList(channelId : String, apiKey : String, onComplete:@escaping onCompleteVideoHandler){
        
        let parameter : Parameters = ["part" : "snippet" as AnyObject,
                                     "maxResults" : 50 as AnyObject,
                                     "playlistId" : channelId as AnyObject,
                                     "key" : apiKey]
        
        AF.request(YoutubePlaylistApi, method:.get, parameters: parameter).responseJSON { (response) in
            
            switch response.result {
            
            case .success:
                let data = response.data
                let youtubeVideo = try? JSONDecoder().decode(YoutubeVideoModel.self, from: data!)
                var VideoArray : [YoutubeVideoObject] = []
                if let videoModel = youtubeVideo{
                    for item in videoModel.items{
                        let videoObject = YoutubeVideoObject(title: item.snippet.title, imageUrl: item.snippet.thumbnails.high.url, duration: "", videoId: item.snippet.resourceID.videoID)
                        VideoArray.append(videoObject)
                    }
                }
                onComplete(VideoArray, nil)
                break
                
            case .failure:
                onComplete(nil, response.error)
                break
                
            }
        }.resume()
    }
}
