//
//  MainViewController.swift
//  Embed Youtube Video
//
//  Created by Sinan on 15.05.2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    var viewModel = HomeViewModel()
    
    @IBOutlet weak var getButton: UIButton!
    @IBOutlet weak var enterIdTextField: UITextField!
    @IBOutlet weak var apiKeyTextField: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }

    @IBAction func changeSegmented(_ sender: UISegmentedControl) {
        let model = viewModel.changeSegmentedIndex(index: SegmentType(rawValue: segmentedControl.selectedSegmentIndex)!)
        enterIdTextField.placeholder = model.placeholder
        enterIdTextField.text = model.textField
        getButton.setTitle(model.buttonTitle, for: .normal)
        
    }
        
    @IBAction func getButtonTapped(_ sender: Any) {
        viewModel.getDetails(enterId: enterIdTextField.text ?? "", apiKey: apiKeyTextField.text ?? "") { success in
            if success{
                switch self.viewModel.segmentIndex {
                case .Video:
                    self.openVideo(id: self.enterIdTextField.text!)
                case .Channel:
                    self.performSegue(withIdentifier: "channelVideoListVC", sender: nil)
                }
            }else{
                self.showAlert(title: "Info", message: "Please enter api key & video id")
            }
        }
    }
}

extension HomeViewController{
    
    func setupNavigationBar(){
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "Helvetica-Bold", size: 25)!]
        self.navigationController?.navigationBar.topItem?.title = "Embed Youtube Videos Easily"
    }
    
    func setupLabel(){
        segmentedControl.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        enterIdTextField.attributedPlaceholder = NSAttributedString(string: viewModel.model.video.placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        apiKeyTextField.attributedPlaceholder = NSAttributedString(string: "Enter Api Key", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
    }

}
