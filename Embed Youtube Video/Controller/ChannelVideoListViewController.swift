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
    }
    

}

extension ChannelVideoListViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VideoListTableViewCell.identifier, for: indexPath) as! VideoListTableViewCell
        return cell
    }
}

extension ChannelVideoListViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
