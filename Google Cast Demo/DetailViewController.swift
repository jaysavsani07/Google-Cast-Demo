//
//  DetailViewController.swift
//  Google Cast Demo
//
//  Created by Jay on 28/02/20.
//  Copyright © 2020 Jay. All rights reserved.
//

import UIKit
import GoogleCast

class DetailViewController: UIViewController {

    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var movieModel: MovieModel?
    var sessionManager: GCKSessionManager!
    private var miniMediaControlsViewController: GCKUIMiniMediaControlsViewController!
    
    var mediaView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = UIImage(named: movieModel!.thumb)
        self.movieTitle.text = movieModel?.title
        self.movieDescription.text = movieModel?.desc
        sessionManager = GCKCastContext.sharedInstance().sessionManager
        
        mediaView = UIView(frame: CGRect(x: 0, y: self.view.frame.height - 70 - (UIApplication.shared.keyWindow?.safeAreaInsets.bottom)!, width: self.view.frame.width, height: 70))

        self.view.addSubview(mediaView!)
        
        let castContext = GCKCastContext.sharedInstance()
        sessionManager.add(self)
        miniMediaControlsViewController = castContext.createMiniMediaControlsViewController()
        miniMediaControlsViewController.delegate = self
        updateControlBarsVisibility(shouldAppear: true)
        installViewController(miniMediaControlsViewController, inContainerView: mediaView!)

    }
    
    func installViewController(_ viewController: UIViewController?, inContainerView containerView: UIView) {
        if let viewController = viewController {
            addChild(viewController)
            viewController.view.frame = containerView.bounds
            containerView.addSubview(viewController.view)
            viewController.didMove(toParent: self)
        }
    }
    
    @IBAction func docPlay(_ sender: Any) {
        let url = URL.init(string: movieModel!.sources)
        guard let mediaURL = url else {
          print("invalid mediaURL")
          return
        }

        let metadata = GCKMediaMetadata()
        metadata.setString(movieModel!.desc, forKey: kGCKMetadataKeyTitle)
        metadata.setString(movieModel!.desc,
                           forKey: kGCKMetadataKeySubtitle)
        metadata.addImage(GCKImage(url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg")!,
                                   width: 480,
                                   height: 360))
        
        let mediaInfoBuilder = GCKMediaInformationBuilder.init(contentURL: mediaURL)
        mediaInfoBuilder.streamType = GCKMediaStreamType.none;
        mediaInfoBuilder.contentType = "video/mp4"
        mediaInfoBuilder.metadata = metadata;
        let mediaInformation = mediaInfoBuilder.build()
        
        if let request = sessionManager.currentSession?.remoteMediaClient?.loadMedia(mediaInformation) {
          request.delegate = self
        }
        GCKCastContext.sharedInstance().presentDefaultExpandedMediaControls()
    }
    
    func updateControlBarsVisibility(shouldAppear: Bool = false) {
        if shouldAppear {
            mediaView!.isHidden = false
        } else {
//            mediaView!.isHidden = true
        }
        UIView.animate(withDuration: 1, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
        view.setNeedsLayout()
    }
}

extension DetailViewController: GCKRequestDelegate {
    
}

extension DetailViewController: GCKUIMiniMediaControlsViewControllerDelegate {
    func miniMediaControlsViewController(_ miniMediaControlsViewController: GCKUIMiniMediaControlsViewController, shouldAppear: Bool) {
        updateControlBarsVisibility(shouldAppear: shouldAppear)
    }
}

extension DetailViewController: GCKSessionManagerListener {
    
}
