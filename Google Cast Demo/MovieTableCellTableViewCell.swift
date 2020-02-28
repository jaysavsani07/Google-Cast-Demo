//
//  MovieTableCellTableViewCell.swift
//  Google Cast Demo
//
//  Created by Jay on 28/02/20.
//  Copyright © 2020 Jay. All rights reserved.
//

import UIKit

class MovieTableCellTableViewCell: UITableViewCell {

    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    class var identifier: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    var movie: MovieModel? {
        didSet {
            self.thumb.image = UIImage(named: movie!.thumb)
            self.title.text = movie?.title!
        }
    }
    
}
