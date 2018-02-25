//
//  ReachOutViewController.swift
//  shOUT
//
//  Apated by Jordan Greissman on 1/3/17 from 
// https://github.com/Vkt0r/AccordionMenuSwift/blob/master/Example/AccordionMenuExample/ViewController.swift.
//  Copyright © 2017 shOUT. All rights reserved.
//

import UIKit

class ReachOutViewController: AccordionTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeNavBar()

        // TODO, more robust, pull from database?, multiple numbers?
        
        let refuge = Parent(state: .collapsed, childs: ["877-229-3042", "www.therefuge-ahealingplace.com/ptsd-treatment/rape/", "The Refuge provides information about rape and sexual assault, and also helps victims heal from the trauma of being assaulted.The main purpose of this center is to help victim acknowledge and accept what has happened to them and move past the event as well as re-acclimate to their old lives."],
            title: "The Refuge",
            type: ["phone", "url", "text"])
        let caps = Parent(state: .collapsed, childs: [
            "607-255-5155",
            "https://www.gannett.cornell.edu/services/counseling/caps/index.cfm",
            "CAPS is dedicated to providing a  confidential and supportive environment for everyone who uses their services. CAPS also offers specific group sessions for sexual assault victims called the Sexual Assault Support Group that meets on Thursdays from 4:30 pm to 6:30pm."],
            title: "CAPS: Counseling and Psychological Services",
            type: ["phone", "url", "text"])
        let police = Parent(state: .collapsed, childs: [
            "212-267-7273",
            "http://www.nyc.gov/html/nypd/html/home/home.shtml",
            "Use this number to report a rape or sexual assault to the New York Police Department."],
            title: "NYPD Sex Crimes Report Line",
            type: ["phone", "url", "text"])
        let safeHarbors = Parent(state: .collapsed, childs: [
            "315-781-1093",
            "http://safeharborsfl.org",
            "Safe Harbors provides free services for individuals, children, and families who have experienced sexual assault, sexual abuse, and interpersonal violence in Ontario, Seneca, and Yates Counties."],
            title: "Safe Harbors of the Finger Lakes, Inc.",
            type: ["phone", "url", "text"])
        let veraHouse = Parent(state: .collapsed, childs: [
            "315-468-3260",
            "http://www.verahouse.org",
            "Vera House is a comprehensive domestic and sexual violence service agency providing shelter, advocacy, and counseling services for women, children, and men."],
            title: "Vera House",
            type: ["phone", "url", "text"])
        
        dataSource = [refuge, caps, police, safeHarbors, veraHouse]
        numberOfCellsExpanded = .one
        total = dataSource.count
    }
}
