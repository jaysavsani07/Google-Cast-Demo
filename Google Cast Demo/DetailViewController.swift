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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = UIImage(named: movieModel!.thumb)
        self.movieTitle.text = movieModel?.title
        self.movieDescription.text = movieModel?.desc

    }
    

}
