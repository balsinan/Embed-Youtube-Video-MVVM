//
//  HomeModel.swift
//  Embed Youtube Video
//
//  Created by Sinan on 26.02.2022.
//

import Foundation

struct HomeModel{
    var video = HomeSegmentModel(textField: "", placeholder: "Video Id", buttonTitle: "Get Videos")
    var channel = HomeSegmentModel(textField: "", placeholder: "Channel Id", buttonTitle: "Get Channel List")
}

struct HomeSegmentModel{
    var textField : String
    var placeholder : String
    var buttonTitle : String
}
