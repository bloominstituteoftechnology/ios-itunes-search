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
        mediaPreview.layer.cornerRadius = 6.0
        
    }
    
    
    @IBAction func playVideo(_ sender: UIButton) {
        guard let url = URL(string: searchResult?.preview ?? " ") else {
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
    
//    func createThumbnailOfVideoFromFileURL(videoURL: String) -> UIImage? {
//        let asset = AVAsset(url: URL(string: videoURL)!)
//        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
//        assetImgGenerate.appliesPreferredTrackTransform = true
//        let time = CMTimeMakeWithSeconds(Float64(1), preferredTimescale: 100)
//        do {
//            let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
//            let thumbnail = UIImage(cgImage: img)
//            return thumbnail
//        } catch {
//            return UIImage(named: "ico_placeholder")
//        }
//    }
//
    

    
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
            
            guard let url = URL(string:searchResult?.artwork ?? " "),
                let artworkData = try? Data(contentsOf: url) else { return }
            artworkDisplay.image = UIImage(data: artworkData)
            artworkDisplay.layer.cornerRadius = 6.0
            artworkDisplay.clipsToBounds = true
        }
        
        if searchResult?.preview == nil {
            mediaPreview.isHidden = true
        } else {
            mediaPreview.isHidden = false
            
            
            
            
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
