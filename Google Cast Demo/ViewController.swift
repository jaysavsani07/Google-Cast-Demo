//
//  ViewController.swift
//  Google Cast Demo
//
//  Created by Jay on 28/02/20.
//  Copyright © 2020 Jay. All rights reserved.
//

import UIKit
import GoogleCast
import SwiftyJSON

class ViewController: UIViewController {

    var array = Array<JSON>()
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let castButton = GCKUICastButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        castButton.tintColor = UIColor.gray
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: castButton)
        tableView.register(MovieTableCellTableViewCell.nib, forCellReuseIdentifier: MovieTableCellTableViewCell.identifier)
        
        if let path = Bundle.main.path(forResource: "sample", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSON(data: data)
                print("jsonData:\(jsonObj)")
                array = jsonObj["categories"][0]["videos"].arrayValue
                tableView.reloadData()
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
        
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableCellTableViewCell.identifier, for: indexPath) as? MovieTableCellTableViewCell
        let movieModel = MovieModel(fromJson: array[indexPath.row])
        cell?.movie = movieModel
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destVC = self.storyboard?.instantiateViewController(withIdentifier: "detail_view") as? DetailViewController
        destVC?.movieModel = MovieModel(fromJson: array[indexPath.row])
        self.navigationController?.pushViewController(destVC!, animated: true)
    }
    
    
}

