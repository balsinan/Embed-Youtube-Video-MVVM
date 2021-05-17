//
//  ChannelVideoListViewController.swift
//  Embed Youtube Video
//
//  Created by Sinan on 15.05.2021.
//

import UIKit

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
        
    }
    
    func setupNavigationBar(){
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.navigationController?.navigationBar.prefersLargeTitles = false
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
        //self.openVideo(id: videoArray[indexPath.row].videoId)
    }
}
