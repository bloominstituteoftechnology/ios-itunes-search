//
//  ResultDetailViewController.swift
//  iTunes Search
//
//  Created by Kat Milton on 7/9/19.
//  Copyright © 2019 Kat Milton. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class ResultDetailViewController: UIViewController {
    
    @IBOutlet var kindLabel: UILabel!
    @IBOutlet var creatorLabel: UILabel!
    @IBOutlet var trackTimeLabel: UILabel!
    @IBOutlet var artworkDisplay: UIImageView!
    @IBOutlet var mediaPreview: UIButton!
   
    
    
    var searchResult: SearchResult? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        self.title = searchResult?.title
        
    }
    
    
    @IBAction func playVideo(_ sender: UIButton) {
        guard let url = URL(string: searchResult?.preview?.previewUrl ?? " ") else {
            return
        }
        // Create an AVPlayer, passing it the HTTP Live Streaming URL.
        let player = AVPlayer(url: url)
        
        // Create a new AVPlayerViewController and pass it a reference to the player.
        let controller = AVPlayerViewController()
        controller.player = player
        
        // Modally present the player and call the player's play() method when complete.
        present(controller, animated: true) {
            player.play()
        }
    }

    
    func updateViews() {
        creatorLabel.text = searchResult?.creator
        kindLabel.text = searchResult?.kind
        
        
        let ms = searchResult?.trackTime
        let runTime = ms?.msToSeconds.minuteSecondMS
        
        if let runTime = runTime {
            if runTime.isEmpty {
                trackTimeLabel.isHidden = true
            } else {
            trackTimeLabel.text = runTime
            }
        }
        
       
        if searchResult?.artwork == nil {
            artworkDisplay.isHidden = true
        } else {
            
            guard let url = URL(string:searchResult?.artwork?.artworkUrl100 ?? " "),
                let artworkData = try? Data(contentsOf: url) else { return }
            artworkDisplay.image = UIImage(data: artworkData)
        }
        
        if searchResult?.preview == nil {
            mediaPreview.isHidden = true
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TimeInterval {
    var minuteSecondMS: String {
        return String(format:"%d:%02d.%03d", minute, second, millisecond)
    }
    var minute: Int {
        return Int((self/60).truncatingRemainder(dividingBy: 60))
    }
    var second: Int {
        return Int(truncatingRemainder(dividingBy: 60))
    }
    var millisecond: Int {
        return Int((self*1000).truncatingRemainder(dividingBy: 1000))
    }
}

extension Int {
    var msToSeconds: Double {
        return Double(self) / 1000
    }
}
