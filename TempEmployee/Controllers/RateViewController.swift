//
//  RateViewController.swift
//  TempEmployee
//
//  Created by kashif Saeed on 11/06/2017.
//  Copyright © 2017 Attribe. All rights reserved.
//
import UIKit
import PKHUD
import Spring

class RateViewController: UIViewController {
    
    @IBOutlet weak var reviewTextView: UITextView!
    @IBOutlet weak var star2: SpringButton!
    @IBOutlet weak var star4: SpringButton!
    @IBOutlet weak var star3: SpringButton!
    @IBOutlet weak var star5: SpringButton!
    @IBOutlet weak var jobseekerNameLabel: UILabel!
    
    var shift :Shift!
    var rating :Int = 0
    var StarsArray:[SpringButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         StarsArray.insert(starPressed, at:0)
         StarsArray.insert(star2, at:1)
         StarsArray.insert(star3, at:2)
         StarsArray.insert(star4, at:3)
         StarsArray.insert(star5, at:4)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var starPressed: SpringButton!
    
    @IBAction func submitRattingPressed(_ sender: Any) {
        
        self.submitRating(service: RateService(), userID: self.shift.assigned_job_seeker_id!, shiftID: self.shift.id, rating: self.rating , review:self.reviewTextView.text)
    }
    @IBOutlet weak var submitRattingPressed: UIButton!
    
    @IBAction func starPressed(_ sender: SpringButton) {
        
        if sender.isSelected{
            for i in sender.tag..<5 {
                StarsArray[i].isSelected = false
                rating -= 1
            }
            
        }else{
            for i in 0..<sender.tag + 1 {
                
            StarsArray[i].isSelected = true
            StarsArray[i].animation = "pop"
            StarsArray[i].animate()
            rating += 1
            }
        }
    }
   
}

extension RateViewController{
    
    func submitRating(service:RateService, userID:Int, shiftID:Int, rating:Int, review:String = "")   {
        
        HUD.show(.progress, onView: self.view)
        
        service.post(shift: self.shift, rating: rating, review: review, completionHandler:{result in
            
            switch result{
                
            case .Success(let response):
                
                if response.success{
                    HUD.hide()
                    self.moveToNextStep()
                }else{
                    HUD.hide()
                    self.errorAlert(description: response.message)
                }
            case .Failure(let error):
                HUD.hide()
                self.errorAlert(description: error.localizedDescription)
            }
            
        } )
    }
    
    func moveToNextStep() {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let thankVC : ThankViewController = storyboard.instantiateViewController()
        self.navigationController?.pushViewController(thankVC, animated: true)
    }
}
