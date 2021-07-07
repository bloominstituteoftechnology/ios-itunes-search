//
//  DetailViewController.swift
//  iTune Search
//
//  Created by Ivan Caldwell on 12/11/18.
//  Copyright © 2018 Ivan Caldwell. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    // Variables and Constants
    var result: Result?
    
    // Outlets and Action
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var creatorLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    
    // Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        titleLabel.text = result?.title
        creatorLabel.text = result?.creator
        
        do {
            let imageURL = URL(string: (result?.image ?? "https://commons.wikimedia.org/wiki/File:No_image_available_600_x_450.svg"))
            let imageData = try Data(contentsOf: imageURL!)
            image.image = UIImage(data: imageData)
        } catch {
            print (error)
        }
    }
    
    
    
}
