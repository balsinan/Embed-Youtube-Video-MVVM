//
//  MainViewController.swift
//  Embed Youtube Video
//
//  Created by Sinan on 15.05.2021.
//

import UIKit

enum SegmentType : Int{
    case Video = 0
    case Channel = 1
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var getButton: UIButton!
    @IBOutlet weak var enterIdTextField: UITextField!
    @IBOutlet weak var apiKeyTextField: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var segmentIndex : SegmentType = .Video

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    func setupNavigationBar(){
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "Helvetica-Bold", size: 25)!]
        self.navigationController?.navigationBar.topItem?.title = "Embed Youtube Videos Easily"
    }
    
    func setupLabel(){
        segmentedControl.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        enterIdTextField.attributedPlaceholder = NSAttributedString(string: "Enter Video Id", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        apiKeyTextField.attributedPlaceholder = NSAttributedString(string: "Enter Api Key", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
    }

    @IBAction func changeSegmented(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex{
        case SegmentType.Video.rawValue:
            segmentIndex = .Video
            enterIdTextField.placeholder = "Video Id"
            enterIdTextField.text = ""
            getButton.setTitle("Get Videos", for: .normal)
            
        case SegmentType.Channel.rawValue:
            segmentIndex = .Channel
            enterIdTextField.placeholder = "Channel Id"
            enterIdTextField.text = ""
            getButton.setTitle("Get Channel List", for: .normal)
        default:
            break
        }
    }
    
    @IBAction func getButtonTapped(_ sender: Any) {
        switch segmentIndex {
        case .Video:
            if enterIdTextField.text != "" && apiKeyTextField.text != ""{
                self.openVideo(id: enterIdTextField.text!)
            } else {
                self.showAlert(title: "Info", message: "Please enter api key & video id")
            }
        case .Channel:
            if enterIdTextField.text != "" && apiKeyTextField.text != ""{
                performSegue(withIdentifier: "channelVideoListVC", sender: nil)
            } else {
                self.showAlert(title: "Info", message: "Please enter api key & channel id")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "channelVideoListVC"{
            let destinationVC = segue.destination as! ChannelVideoListViewController
            destinationVC.apiKey = apiKeyTextField.text!
            destinationVC.channelId = enterIdTextField.text!
        }
    }
}
