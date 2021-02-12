//
//  ChartFormatter.swift
//  UnderArmourStepTracker
//
//  Created by Pranav Bhandari on 4/30/18.
//  Copyright © 2018 Pranav Bhandari. All rights reserved.
//

import UIKit
import Charts

public class ChartFormatter: NSObject, IAxisValueFormatter {
    var date = [String]()
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return date[Int(value)]
    }
    
    public func setValues(_ values: [String]) {
        self.date = values
    }
}
