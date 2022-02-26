//
//  HomeViewModel.swift
//  Embed Youtube Video
//
//  Created by Sinan on 26.02.2022.
//

import Foundation



class HomeViewModel{
    
    let model : HomeModel  = HomeModel()
    
    var segmentIndex : SegmentType = .Video
    
    func getDetails(enterId: String, apiKey: String, completion: @escaping (Bool) -> Void){
        if enterId != "" && apiKey != ""{
            Constant.apiKey = apiKey
            Constant.channelId = enterId
            completion(true)
        } else {
            completion(false)
        }
    }
    
    func changeSegmentedIndex(index: SegmentType) -> HomeSegmentModel{
        segmentIndex = index
        switch index {
        case .Video:
            return model.video
        case .Channel:
            return model.channel
        }
        
    }
}

enum SegmentType : Int{
    case Video = 0
    case Channel = 1
}


