//
//  ViewController.swift
//  MPMusicPlayerControllerAppendPrependSample
//
//  Created by hiraya.shingo on 2017/02/01.
//  Copyright © 2017年 hiraya.shingo. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UITableViewController {
    let musicPlayerController = MPMusicPlayerController.systemMusicPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // check Authorization
        MPMediaLibrary.requestAuthorization { status in
            print("status:", status == .authorized ? "authorized" : "Not authorized")
        }
    }
    
    @IBAction func addButtonDidTap(_ sender: Any) {
        // present MPMediaPickerController
        let picker = MPMediaPickerController(mediaTypes: .music)
        picker.allowsPickingMultipleItems = true
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    func setQueue(mediaItemCollection: MPMediaItemCollection) {
        // setQueue and prepare
        let descriptor = MPMusicPlayerMediaItemQueueDescriptor(itemCollection: mediaItemCollection)
        musicPlayerController.setQueueWith(descriptor)
        musicPlayerController.play()
    }
    
    func appendQueue(mediaItemCollection: MPMediaItemCollection) {
        let descriptor = MPMusicPlayerMediaItemQueueDescriptor(itemCollection: mediaItemCollection)
        
        // append: Adds the contents of the queue descriptor to the end of the queue
        
        // append method is not work as expected with iOS 10.3 beta 2
        musicPlayerController.append(descriptor)
    }
    
    func prependQueue(mediaItemCollection: MPMediaItemCollection) {
        let descriptor = MPMusicPlayerMediaItemQueueDescriptor(itemCollection: mediaItemCollection)
        
        // prepend: Inserts the contents of the queue descriptor after the now playing item
        
        // prepend method is not work as expected with iOS 10.3 beta 2
        musicPlayerController.prepend(descriptor)
    }
}

// MARK: - MPMediaPickerControllerDelegate
extension ViewController: MPMediaPickerControllerDelegate {
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        let ac = UIAlertController(title: nil,
                                   message: nil,
                                   preferredStyle: .actionSheet)
        ac.addAction(
            UIAlertAction(title: "setQueue",
                          style: .default) { action in
                            print("setQueue")
                            self.setQueue(mediaItemCollection: mediaItemCollection)
            }
        )
        ac.addAction(
            UIAlertAction(title: "append",
                          style: .default) { action in
                            print("append")
                            self.appendQueue(mediaItemCollection: mediaItemCollection)
            }
        )
        ac.addAction(
            UIAlertAction(title: "prepend",
                          style: .default) { action in
                            print("prepend")
                            self.prependQueue(mediaItemCollection: mediaItemCollection)
            }
        )
        
        mediaPicker.dismiss(animated: true) {
            self.present(ac, animated: true, completion: nil)
        }
    }
    
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        mediaPicker.dismiss(animated: true, completion: nil)
    }
}
