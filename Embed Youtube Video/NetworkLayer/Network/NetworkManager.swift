//
//  YoutubeApi.swift
//  Embed Youtube Video
//
//  Created by Sinan on 17.05.2021.
//

import Foundation
import Alamofire


class NetworkManager{
    
    static let sharedInstance = NetworkManager()
    
    public typealias onCompleteVideoHandler = (([YoutubeVideoObject]?,NetworkingErrors?)->())
    
    func fetchChannelVideoList(channelId : String, apiKey : String, onComplete:@escaping onCompleteVideoHandler){
        
        let parameter : Parameters = ["part" : "snippet" as AnyObject,
                                     "maxResults" : 50 as AnyObject,
                                     "playlistId" : channelId as AnyObject,
                                     "key" : apiKey]
        
        AF.request(Constant.YoutubePlaylistApi, method:.get, parameters: parameter).responseJSON { (response) in
            switch response.result {
            case .success:
                let statusCode = response.response?.statusCode
                switch statusCode {
                case 200:
                    let data = response.data
                    let youtubeVideo = try? JSONDecoder().decode(YoutubeVideoModel.self, from: data!)
                    var videoArray : [YoutubeVideoObject] = []
                    if let videoModel = youtubeVideo{
                        for item in videoModel.items{
                            let obj = YoutubeVideoObject(title: item.snippet.title, imageUrl: item.snippet.thumbnails.high.url, duration: "", videoId: item.snippet.resourceID.videoID)
                            videoArray.append(obj)
                        }
                    }
                    onComplete(videoArray, nil)
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
    
    public typealias onCompleteDurationHandler = ((String,AFError?)->())
    
    func getVideoDuration(videoId : String, apiKey : String, onComplete:@escaping onCompleteDurationHandler){
        
        let parameter : Parameters = [
          "part" : "contentDetails" as AnyObject,
          "id" : videoId as AnyObject,
          "key" : apiKey
        ]
        
        AF.request(Constant.YoutubeVideoDetailApi, method:.get, parameters: parameter).responseJSON { (response) in
            
            switch response.result {
                case .success:
                    let data = response.data
                    let durationModel = try? JSONDecoder().decode(VideoDurationModel.self, from: data!)
                    let duration = durationModel?.items.first?.contentDetails.duration
                let convertDuration = VideoHelper.sharedInstance.parseVideoDurationOfYoutubeAPI(videoDuration: duration)
                    onComplete(convertDuration,nil)
                    break
                case .failure:
                    onComplete("",response.error)
                    break
            }
        }.resume()
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

