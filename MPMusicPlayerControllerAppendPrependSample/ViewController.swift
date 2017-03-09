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
}

// MARK: - MPMediaPickerControllerDelegate
extension ViewController: MPMediaPickerControllerDelegate {
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        
        // MPMusicPlayerController append and prepend don't work with MPMusicPlayerMediaItemQueueDescriptor constructed with MPMediaItemCollection.
        // http://www.openradar.me/30298287
        
        // This bug Reproduced with iOS 10.3 beta 5
        
        // Therefore, use MPMusicPlayerMediaItemQueueDescriptor constructed with MPMediaQuery.
        let predicate = MPMediaPropertyPredicate(value: mediaItemCollection.representativeItem!.persistentID,
                                                 forProperty: MPMediaItemPropertyPersistentID)
        let query = MPMediaQuery(filterPredicates: [predicate])
        let descriptor = MPMusicPlayerMediaItemQueueDescriptor(query: query)
        
        let ac = UIAlertController(title: nil,
                                   message: nil,
                                   preferredStyle: .actionSheet)
        ac.addAction(
            UIAlertAction(title: "set queue and play",
                          style: .default) { action in
                            print("set queue and play")
                            self.musicPlayerController.setQueueWith(descriptor)
                            self.musicPlayerController.play()
            }
        )
        ac.addAction(
            UIAlertAction(title: "append",
                          style: .default) { action in
                            print("append")
                            self.musicPlayerController.append(descriptor)
            }
        )
        ac.addAction(
            UIAlertAction(title: "prepend",
                          style: .default) { action in
                            print("prepend")
                            self.musicPlayerController.prepend(descriptor)
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
