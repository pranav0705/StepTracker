//
//  Home_StepTableViewCell.swift
//  UnderArmourStepTracker
//
//  Created by Pranav Bhandari on 4/28/18.
//  Copyright © 2018 Pranav Bhandari. All rights reserved.
//

import UIKit

class Home_StepTableViewCell: UITableViewCell {

    @IBOutlet weak var monthLbl: UILabel!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var stepView: UIView!
    @IBOutlet weak var stepLbl: UILabel!
    
    func configureCell(cell: UITableViewCell, cellForRowAt indexPath: IndexPath, stepCount: String, date: String){
        
        //setting step counts
        stepLbl.text = stepCount
        stepView.backgroundColor = Int(stepCount)! > 2000 ? greenColor : redColor
       
        
        //Setting date labels
        let splitUpDateString = date.components(separatedBy: " ")
        dayLbl.text = splitUpDateString[0]
        monthLbl.text = splitUpDateString[1]
        
    }
    

}
