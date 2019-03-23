//
//  SecondPageController.swift
//  Book_Sources
//
//  Created by Adauto Pinheiro on 18/03/19.
//

import Foundation
import PlaygroundSupport
import GameplayKit
import SpriteKit

@objc(Book_Sources_AboutMePageController)
public class AboutMePageController: UIViewController, PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer {
    let photo = UIImageView(image: UIImage(named: "Me"))
    /*
     public func liveViewMessageConnectionOpened() {
     // Implement this method to be notified when the live view message connection is opened.
     // The connection will be opened when the process running Contents.swift starts running and listening for messages.
     }
     */
    
    /*
     public func liveViewMessageConnectionClosed() {
     // Implement this method to be notified when the live view message connection is closed.
     // The connection will be closed when the process running Contents.swift exits and is no longer listening for messages.
     // This happens when the user's code naturally finishes running, if the user presses Stop, or if there is a crash.
     }
     */
    
    public func receive(_ message: PlaygroundValue) {
        
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(photo)
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.layer.masksToBounds = false
        photo.contentMode = .scaleAspectFill
        photo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        photo.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        photo.widthAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true
        photo.heightAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true
        photo.clipsToBounds = true
        view.backgroundColor = UIColor(red: 24/255, green: 15/255, blue: 66/255, alpha: 1)
        
    }
    public override func viewDidLayoutSubviews() {
        photo.layer.cornerRadius = photo.frame.size.height/2
    }

}
