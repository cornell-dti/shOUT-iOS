//
//  PostViewController.swift
//  shOUT
//
//  Created by Jordan Greissman on 1/9/17.
//  Copyright © 2017 shOUT. All rights reserved.
//
import UIKit
import CoreLocation
import Firebase

class PostViewController: UIViewController, UITextViewDelegate, CLLocationManagerDelegate {

    var box: UIView!
    var currLocation: CLLocationCoordinate2D?
    var reset:Bool = false
    var reportLabel: UILabel!
    var titleTextField: UITextField!
    var dateLabel: UILabel!
    var timeLabel: UILabel!
    var locationLabel: UILabel!
    var storyTextView: UITextView!
    var postButton: UIButton!
    var cancelButton: UIButton!
    
    let ref = FIRDatabase.database().reference(withPath: "messages")
    let locationManager = CLLocationManager()
    
    private func  alert() {
        print("start")
        let alert = UIAlertController(title: "Cannot fetch your location", message: "Please enable location in the settings menu", preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        let settings = UIAlertAction(title: "Settings", style: UIAlertActionStyle.default) { (action) -> Void in
            UIApplication.shared.openURL(NSURL(string: UIApplicationOpenSettingsURLString)! as URL)
            return
        }
        alert.addAction(settings)
        alert.addAction(action)
        print("end")
        self.present(alert, animated: true, completion: nil)
        print("after")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    //    makeNavBar()
        
        view.backgroundColor = UIColor(hue: 0.4861, saturation: 0, brightness: 0.93, alpha: 1.0)
        
        box = UIView(frame: .zero)
        box.backgroundColor = .white
        view.addSubview(box)
        
        box.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(UIApplication.shared.statusBarFrame.height + 5)
            make.width.equalTo(view.snp.width).offset(-20)
            make.height.equalTo(view.snp.height).offset(-20 - UIApplication.shared.statusBarFrame.height)
            make.centerX.equalTo(view.snp.centerX)
        //    make.center.equalTo(view.snp.center)
        }
        
        reportLabel = UILabel(frame: .zero)
        reportLabel.textAlignment = .center
        reportLabel.font = UIFont(name: "Lato", size: 18)
        reportLabel.textColor = .darkGray
        reportLabel.adjustsFontSizeToFitWidth = true
        reportLabel.text = "Report an Incident!"
        view.addSubview(reportLabel)
        
        reportLabel.snp.makeConstraints { (make) in
            make.width.equalTo(box.snp.width).dividedBy(2.0)
            make.top.equalTo(box.snp.top).offset(20)
            make.height.equalTo(50)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        titleTextField = UITextField(frame: .zero)
        titleTextField.text = "Title"
        titleTextField.textAlignment = .center
        titleTextField.textColor = .lightGray
        view.addSubview(titleTextField)
        
        titleTextField.snp.makeConstraints { (make) in
            make.width.equalTo(box.snp.width).multipliedBy(0.75)
            make.height.equalTo(25)
            make.top.equalTo(reportLabel.snp.bottom).offset(5)
            make.centerX.equalTo(view.snp.centerX)
            titleTextField.setBottomBorder()
        }
        
        dateLabel = UILabel(frame: .zero)
        dateLabel.textAlignment = .center
        dateLabel.font = reportLabel.font
        dateLabel.textColor = .lightGray
        dateLabel.adjustsFontSizeToFitWidth = true
        dateLabel.text = "Tap icon to add a date"
        view.addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints { (make) in
            make.width.equalTo(titleTextField.snp.width)
            make.height.equalTo(titleTextField.snp.height)
            make.top.equalTo(titleTextField.snp.bottom).offset(15)
            make.centerX.equalTo(view.snp.centerX)
            dateLabel.setBottomBorder()
        }
        
        timeLabel = UILabel(frame: .zero)
        timeLabel.textAlignment = .center
        timeLabel.font = reportLabel.font
        timeLabel.textColor = .lightGray
        timeLabel.adjustsFontSizeToFitWidth = true
        timeLabel.text = "Tap icon to add a time"
        view.addSubview(timeLabel)
        
        timeLabel.snp.makeConstraints { (make) in
            make.width.equalTo(titleTextField.snp.width)
            make.height.equalTo(titleTextField.snp.height)
            make.top.equalTo(dateLabel.snp.bottom).offset(15)
            make.centerX.equalTo(view.snp.centerX)
            timeLabel.setBottomBorder()
        }
        
        locationLabel = UILabel(frame: .zero)
        locationLabel.textAlignment = .center
        locationLabel.font = reportLabel.font
        locationLabel.textColor = .lightGray
        locationLabel.adjustsFontSizeToFitWidth = true
        locationLabel.text = "Tap icon to add a location"
        view.addSubview(locationLabel)
        
        locationLabel.snp.makeConstraints { (make) in
            make.width.equalTo(titleTextField.snp.width)
            make.height.equalTo(titleTextField.snp.height)
            make.top.equalTo(timeLabel.snp.bottom).offset(15)
            make.centerX.equalTo(view.snp.centerX)
            locationLabel.setBottomBorder()
        }
        
        storyTextView = UITextView(frame: .zero)
        storyTextView.backgroundColor = UIColor(hue: 0.4861, saturation: 0, brightness: 0.93, alpha: 1.0)
        storyTextView.isEditable = true
        storyTextView.text = "Share your story here..."
        storyTextView.textColor = .darkGray
        view.addSubview(storyTextView)
        
        storyTextView.snp.makeConstraints { (make) in
            make.width.equalTo(box.snp.width).multipliedBy(0.85)
            make.height.equalTo(275)
            make.top.equalTo(locationLabel.snp.bottom).offset(30)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        postButton = UIButton(frame: .zero)
        postButton.backgroundColor = .darkGray
        postButton.setTitleColor(.white, for: .normal)
        postButton.setTitle("POST", for: .normal)
        postButton.addTarget(self, action: #selector(postButtonPressed), for: .touchUpInside)
        postButton.clipsToBounds = true
        postButton.layer.cornerRadius = 25
        view.addSubview(postButton)
        
        postButton.snp.makeConstraints { (make) in
            make.width.equalTo(storyTextView.snp.width).multipliedBy(0.5)
            make.height.equalTo(50)
            make.right.equalTo(view.snp.centerX).offset(-5)
            make.top.equalTo(storyTextView.snp.bottom).offset(20)
        }
        
        cancelButton = UIButton(frame: .zero)
        cancelButton.backgroundColor = .darkGray
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.setTitle("CANCEL", for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        cancelButton.clipsToBounds = true
        cancelButton.layer.cornerRadius = 25
        view.addSubview(cancelButton)
        
        cancelButton.snp.makeConstraints { (make) in
            make.width.equalTo(storyTextView.snp.width).multipliedBy(0.5)
            make.height.equalTo(50)
            make.left.equalTo(view.snp.centerX).offset(5)
            make.top.equalTo(storyTextView.snp.bottom).offset(20)
        }
        
   //     let body = self.bodyView!
   //     let title = self.titleView!
   //
   //     body.delegate = self
   //     body.becomeFirstResponder()
   //     body.text = "What's on your mind?"
   //     body.textColor = UIColor.lightGray
        
   //     title.delegate = self
   //     title.becomeFirstResponder()
    //    title.text = "Title"
   //     title.textColor = UIColor.lightGray
        
        // TODO only if they check that they want location recorded
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func postButtonPressed() {
        
    }
    
    @objc func cancelButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "What's on your mind?"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        locationManager.stopUpdatingLocation()
        if(locations.count > 0){
            let location = locations[0] as! CLLocation
            currLocation = location.coordinate
        } else {
            alert()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelPressed(_ sender: AnyObject) {
        self.dismiss(animated: true , completion: nil)
    }
    
  //  @IBAction func postPressed(_ sender: Any) {
  //      let date = NSDate()
        
        // TODO: Dummy value if no location
        
        //        if(currLocation != nil){
        // Push data to Firebase Database
  //      let post = Constants.Post(
  //          fromTitle: self.titleView.text, fromBody: self.bodyView.text, fromDate: date)
  //      let userRef = self.ref.childByAutoId()
  //      userRef.setValue(post.toAnyObject())
        
  //      self.dismiss(animated: true , completion: nil)
        //        } else {
        //            alert()
        //        }
  //  }
    
    
    
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
