//
//  YoutubeApi.swift
//  Embed Youtube Video
//
//  Created by Sinan on 17.05.2021.
//

import Foundation
import Alamofire

let YoutubePlaylistApi = "https://www.googleapis.com/youtube/v3/playlistItems"
let YoutubeVideoDetailApi = "https://www.googleapis.com/youtube/v3/videos"

class YoutubeApi{
    static let sharedInstance = YoutubeApi()
    public typealias onCompleteVideoHandler = (([YoutubeVideoObject]?,NetworkingErrors?)->())
    
    func fetchChannelVideoList(channelId : String, apiKey : String, onComplete:@escaping onCompleteVideoHandler){
        
        let parameter : Parameters = ["part" : "snippet" as AnyObject,
                                     "maxResults" : 50 as AnyObject,
                                     "playlistId" : channelId as AnyObject,
                                     "key" : apiKey]
        
        AF.request(YoutubePlaylistApi, method:.get, parameters: parameter).responseJSON { (response) in
            switch response.result {
            case .success:
                let statusCode = response.response?.statusCode
                switch statusCode {
                case 200:
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
                case 400:
                    onComplete(nil, .playlistOperationUnsupported)
                    break
                case 403:
                    onComplete(nil, .playlistItemsNotAccessible)
                    break
                case 404:
                    onComplete(nil, .playlistNotFound)
                    break
                default:
                    break
                }
        
            case .failure:
                onComplete(nil, .failure)
                break
            }
        }.resume()
    }
   
    public typealias onCompleteDurationHandler = ((Bool,AFError?)->())
    
    func fetchVideoDuration(videoId : String, apiKey : String, videoObject : YoutubeVideoObject, onComplete:@escaping onCompleteDurationHandler){
        
        let parameter : Parameters = [
          "part" : "contentDetails" as AnyObject,
          "id" : videoId as AnyObject,
          "key" : apiKey
        ]
        
        AF.request(YoutubeVideoDetailApi, method:.get, parameters: parameter).responseJSON { (response) in
            
            switch response.result {
                case .success:
                    let data = response.data
                    let durationModel = try? JSONDecoder().decode(VideoDurationModel.self, from: data!)
                    let duration = durationModel?.items.first?.contentDetails.duration
                    videoObject.duration = self.parseVideoDurationOfYoutubeAPI(videoDuration: duration)
                    onComplete(true,nil)
                    break
                
                case .failure:
                    onComplete(false,response.error)
                    break
            }
        }.resume()
    }
     
    func parseVideoDurationOfYoutubeAPI(videoDuration: String?) -> String {

        var videoDurationString = videoDuration! as NSString
        var hours: Int = 0
        var minutes: Int = 0
        var seconds: Int = 0
        let timeRange = videoDurationString.range(of: "T")

        videoDurationString = videoDurationString.substring(from: timeRange.location) as NSString
        while videoDurationString.length > 1 {

            videoDurationString = videoDurationString.substring(from: 1) as NSString
            let scanner = Scanner(string: videoDurationString as String) as Scanner
            var part: NSString?
            scanner.scanCharacters(from: NSCharacterSet.decimalDigits, into: &part)
            let partRange: NSRange = videoDurationString.range(of: part! as String)
            videoDurationString = videoDurationString.substring(from: partRange.location + partRange.length) as NSString
            let timeUnit: String = videoDurationString.substring(to: 1)

            if (timeUnit == "H") {
                hours = Int(part! as String)!
            }else if (timeUnit == "M") {
                minutes = Int(part! as String)!
            }else if (timeUnit == "S") {
                seconds   = Int(part! as String)!
            }
        }
        
        if hours == 0 {
            return String(format: "%02d:%02d", minutes,seconds)
        }
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    enum NetworkingErrors : Error{
        case playlistItemsNotAccessible
        case watchHistoryNotAccessible
        case watchLaterNotAccessible
        case playlistNotFound
        case videoNotFound
        case playlistIdRequired
        case playlistOperationUnsupported
        case failure
        
        var localizedDescription : String{
            switch self{
            case .playlistItemsNotAccessible:
                return "The request is not properly authorized to retrieve the specified playlist."
            case .watchHistoryNotAccessible:
                return "Watch history data cannot be retrieved through the API."
            case .watchLaterNotAccessible:
                return "Items in watch later playlists cannot be retrieved through the API."
            case .playlistNotFound:
                return "The playlist identified with the request's playlistId parameter cannot be found."
            case .videoNotFound:
                return "The video identified with the request's videoId parameter cannot be found."
            case .playlistIdRequired:
                return "The subscribe request does not specify a value for the required playlistId property."
            case .playlistOperationUnsupported:
                return "The API does not support the ability to list videos in the specified playlist. For example, you can't list a video in your watch later playlist."
            case .failure:
                return "Failure."
            }
        }
    }
}

