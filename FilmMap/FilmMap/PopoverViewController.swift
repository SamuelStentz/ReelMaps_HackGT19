//
//  PopoverViewController.swift
//  FilmMap
//
//  Created by Abhinav Tirath on 10/27/19.
//  Copyright © 2019 Abhinav Tirath. All rights reserved.
//

import UIKit

class PopoverViewController: UIViewController {
    
    var movieTitle: String = ""
    var sceneTitle: String = ""
    var sceneDescription: String = ""
    var imageLink: String = ""
    var videoLink: String = ""
    var purchaseLink: String = ""
    
    @IBOutlet var sceneDescriptionLabel: UILabel!
    @IBOutlet var sceneTitleLabel: UILabel!
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var watchClipButton: UIButton!
    @IBOutlet var buyMovieButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneDescriptionLabel.text = sceneDescription
        movieTitleLabel.text = movieTitle
        sceneTitleLabel.text = sceneTitle
        
        sceneTitleLabel.sizeToFit()
        sceneDescriptionLabel.sizeToFit()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if imageLink != "" {
            let url = URL(string: imageLink)
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            imageView.image = UIImage(data: data!)
        }
        if videoLink == "" {
            watchClipButton.isEnabled = false
        }
        if purchaseLink == "" {
            buyMovieButton.isEnabled = false
        }
    }
    
    @IBAction func watchClipPressed(_ sender: Any) {
        guard let url = URL(string: videoLink) else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func buyMoviePressed(_ sender: Any) {
        guard let url = URL(string: purchaseLink) else { return }
        UIApplication.shared.open(url)
    }
}
