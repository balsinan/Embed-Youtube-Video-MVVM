//
//  ChannelVideoListViewController.swift
//  Embed Youtube Video
//
//  Created by Sinan on 15.05.2021.
//

import UIKit
import KRProgressHUD

class ChannelVideoListViewController: UIViewController {
    
    var viewModel = ChannelListViewModel(service: NetworkManager())
    
    private let tableView : UITableView = {
        let table = UITableView()
        table.register(VideoListTableViewCell.self, forCellReuseIdentifier: VideoListTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupNavigationBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchVideoList()
    }
    
    func fetchVideoList(){
        viewModel.getVideoList { err in
            if let err = err{
                print(err.localizedDescription)
            }else{
                self.tableView.reloadData()
            }
        }
    }
}

extension ChannelVideoListViewController{
    fileprivate func setupTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = view.frame
        tableView.backgroundColor = #colorLiteral(red: 0.04705882353, green: 0.06274509804, blue: 0.09803921569, alpha: 1)
        view.addSubview(tableView)
    }
    
    fileprivate func setupNavigationBar(){
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
}

extension ChannelVideoListViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VideoListTableViewCell.identifier, for: indexPath) as! VideoListTableViewCell
        let video = viewModel.videoAtIndex(indexPath.row)
        cell.configureCell(videoObject : video)
        return cell
    }
}

extension ChannelVideoListViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let video = viewModel.videoAtIndex(indexPath.row)
        self.openVideo(id: video.videoId)
    }
}
