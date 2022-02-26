//
//  ChannelListViewModel.swift
//  Embed Youtube Video
//
//  Created by Sinan on 26.02.2022.
//

import Foundation

class ChannelListViewModel {
    
    private let service : NetworkManager
   
    var videoList : [YoutubeVideoObject] = []
    
    init(service:NetworkManager) {
        self.service = service
    }
    
    func numberOfRowSection() -> Int {
        return self.videoList.count
    }
    
    func videoAtIndex(_ index: Int) -> ChannelViewModel {
        let video = self.videoList[index]
        return ChannelViewModel(video: video)
    }

    func getVideoList( _ completion : @escaping (Error?) -> Void) {
        
        service.fetchChannelVideoList(channelId: Constant.channelId, apiKey: Constant.apiKey) { videos, error in
            if let err = error{
                completion(err.localizedDescription as? Error)
            }else{
                if let list = videos{
                    self.videoList = list
                    self.getVideoDuration {
                        completion(nil)
                    }
                }
                
            }
        }
    }
    
    func getVideoDuration( _ success : @escaping () -> Void) {
        var count = 0
        for video in videoList{
            service.getVideoDuration(videoId: video.videoId, apiKey: Constant.apiKey) { duration, err in
                video.duration = duration
                count += 1
                if count == self.videoList.count{
                    success()
                }
            }
        }
    }
}

struct ChannelViewModel {
    let video : YoutubeVideoObject
    
    var title : String {
        return video.title
    }
    
    var imageUrl : String {
        return video.imageUrl
    }
    
    var duration : String {
        return video.duration
    }
    
    var videoId : String {
        return video.videoId
    }
    
}
