//
//  ViewController.swift
//  PushNotifications
//
//  Created by BetterDeals on 3/16/18.
//  Copyright © 2018 BetterDeals. All rights reserved.
//

import UIKit
import UserNotifications
class ViewController: UIViewController {

    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var viewConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) {(success, error) in
            if error == nil{
                print("AS")
            }
        }
        blurView.layer.cornerRadius = 15
        sideView.layer.shadowColor  = UIColor.black.cgColor
        sideView.layer.shadowOpacity = 0.8
        sideView.layer.shadowOffset = CGSize(width: 5, height: 0)
        
        viewConstraint.constant = -175
        timedNotification(inSeconds: 3) { (success) in
            if success{
                print("SN")
            }
            
        }    }
    @IBAction func notifyPressed(_ sender: UIButton) {
        timedNotification(inSeconds: 3) { (success) in
            if success{
                print("SN")
            }
            
        }
    }
    
    func timedNotification(inSeconds: TimeInterval, completion: @escaping (_ success: Bool) -> ()){
        
        guard let imageURL = Bundle.main.url(forResource: "h", withExtension: "jpg")else{
            completion(false)
            return
        }
        
        let attachment =  try! UNNotificationAttachment(identifier: "h", url: imageURL, options: .none)
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = "New episode"
        content.body = "Watch  this weeks neew episode 131 now!"
        content.attachments = [attachment]
        
        let request = UNNotificationRequest(identifier: "customNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if error == nil{
                completion(true)
            }else{
                completion(false)
            }
            
        }
        
    }
    
    @IBAction func panGesture(_ sender: UIPanGestureRecognizer) {
        
        if sender.state == .began || sender.state == .changed{
            let translation = sender.translation(in: self.view).x
            
            if translation > 0 {
                if viewConstraint.constant < 20 {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.viewConstraint.constant += translation / 10
                        self.view.layoutIfNeeded()
                    })
                }
            } else {
                if viewConstraint.constant > -175 {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.viewConstraint.constant += translation / 10
                        self.view.layoutIfNeeded()
                    })
                }            }
        }else if sender.state == .ended{
            if viewConstraint.constant < -100{
                UIView.animate(withDuration: 0.2, animations: {
                    self.viewConstraint.constant = -175
                    self.view.layoutIfNeeded()
                })
                
            }else{
                UIView.animate(withDuration: 0.2, animations: {
                    self.viewConstraint.constant = 0
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    


}

