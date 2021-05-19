//
//  ChannelVideoListViewController.swift
//  Embed Youtube Video
//
//  Created by Sinan on 15.05.2021.
//

import UIKit
import KRProgressHUD

class ChannelVideoListViewController: UIViewController {
    
    var apiKey = ""
    var channelId = ""
    
    var videoArray : [YoutubeVideoObject] = []
    
    private let tableView : UITableView = {
        let table = UITableView()
        table.register(VideoListTableViewCell.self, forCellReuseIdentifier: VideoListTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = view.bounds
    
        setupNavigationBar()
        fetchVideoList()
        
    }
    
    func setupNavigationBar(){
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func fetchVideoList(){
        KRProgressHUD.show()
        YoutubeApi.sharedInstance.fetchChannelVideoList(channelId: channelId, apiKey: apiKey) { objectArray, error in
            if let error = error{
                self.showAlert(title: "Error", message: error.localizedDescription)
                KRProgressHUD.dismiss()
            }else{
                if let videos : [YoutubeVideoObject] = objectArray{
                    self.videoArray = videos
                    
                    for video in videos{
                        self.fetchVideoDuration(videoId: video.videoId, apiKey: self.apiKey, videobject: video)
                    }
                }
            }
        }
    }
    
    func fetchVideoDuration(videoId: String, apiKey: String, videobject: YoutubeVideoObject){
        YoutubeApi.sharedInstance.fetchVideoDuration(videoId: videoId, apiKey: apiKey, videoObject: videobject) { success, error in
            if success{
                self.tableView.reloadData()
                KRProgressHUD.dismiss()
            }else{
                self.showAlert(title: "Error", message: error?.localizedDescription ?? "")
                KRProgressHUD.dismiss()
            }
        }
    }
}

extension ChannelVideoListViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VideoListTableViewCell.identifier, for: indexPath) as! VideoListTableViewCell
        cell.configureCell(videoObject : videoArray[indexPath.row])
        return cell
    }
}

extension ChannelVideoListViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.openVideo(id: videoArray[indexPath.row].videoId)
    }
}
