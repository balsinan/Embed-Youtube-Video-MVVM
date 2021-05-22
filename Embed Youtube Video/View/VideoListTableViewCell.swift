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
        label.font = UIFont(name: "Avenir-Medium", size: 15)
        return label
    }()
    
    private let durationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Avenir-Heavy", size: 17)
        label.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        label.textAlignment = .center
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.backgroundColor = #colorLiteral(red: 0.04705882353, green: 0.06274509804, blue: 0.09803921569, alpha: 1)
        videoImage.frame = CGRect(x: 0,
                                  y: 0,
                                  width: self.frame.size.width,
                                  height: 190)
        videoTitleLabel.frame = CGRect(x: 15,
                                       y: videoImage.frame.maxY + 10,
                                       width: self.frame.size.width - 30,
                                       height: 40)
        durationLabel.frame = CGRect(x: self.frame.size.width - 70,
                                     y: videoImage.frame.maxY - 40,
                                     width: 60,
                                     height: 30)
        
    }
    
}
