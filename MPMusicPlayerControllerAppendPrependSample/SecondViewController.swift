//
//  SecondViewController.swift
//  MPMusicPlayerControllerAppendPrependSample
//
//  Created by hiraya.shingo on 2017/03/09.
//  Copyright © 2017年 hiraya.shingo. All rights reserved.
//

import UIKit
import MediaPlayer

class SecondViewController: UIViewController {
    let musicPlayerController = MPMusicPlayerController.systemMusicPlayer()
    
    @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapSetQueueAndPlay(_ sender: Any) {
        guard let storeID = textField.text else { return }
        
        let descriptor = MPMusicPlayerStoreQueueDescriptor(storeIDs: [storeID])
        musicPlayerController.setQueueWith(descriptor)
        musicPlayerController.play()
    }

    @IBAction func didtapAppend(_ sender: Any) {
        guard let storeID = textField.text else { return }
        
        // Use append method with MPMusicPlayerStoreQueueDescriptor
        // Sample app for how to get storeID is here: https://github.com/hirayaCM/MusicSearch
        
        let descriptor = MPMusicPlayerStoreQueueDescriptor(storeIDs: [storeID])
        musicPlayerController.append(descriptor)
    }

    @IBAction func didTapPrepend(_ sender: Any) {
        guard let storeID = textField.text else { return }
        
        // Use prepend method with MPMusicPlayerStoreQueueDescriptor
        
        let descriptor = MPMusicPlayerStoreQueueDescriptor(storeIDs: [storeID])
        musicPlayerController.prepend(descriptor)
    }
}
