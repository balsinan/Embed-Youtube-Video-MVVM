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

        setupNavigationBar()
    }
    
    func setupNavigationBar(){
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont(name: "Helvetica-Bold", size: 25)!]
        self.navigationController?.navigationBar.topItem?.title = "Embed Youtube Videos Easily"
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
            break;
        }
    }
    
    @IBAction func getButtonTapped(_ sender: Any) {
        switch segmentIndex {
        case .Video:
            if enterIdTextField.text != "" && apiKeyTextField.text != ""{
                //open video
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
