//
//  VideoListTableViewCell.swift
//  Embed Youtube Video
//
//  Created by Sinan on 15.05.2021.
//

import UIKit

class VideoListTableViewCell: UITableViewCell {
    
    static let identifier = "videoListCell"
    
    private let videoImage : UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let videoTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private let durationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(videoImage)
        contentView.addSubview(videoTitleLabel)
        contentView.addSubview(durationLabel)
        contentView.clipsToBounds = true
    }
    
    func configureCell(videoObject : YoutubeVideoObject){
        self.videoTitleLabel.text = videoObject.title
        self.durationLabel.text = videoObject.duration
        let url = URL(string:videoObject.imageUrl)
        self.imageView?.image = nil
        DispatchQueue.main.async() { [weak self] in
            let data = try? Data(contentsOf: url!)
            self!.videoImage.image = UIImage(data: data!)
         }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
