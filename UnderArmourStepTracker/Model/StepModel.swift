//
//  StepModel.swift
//  UnderArmourStepTracker
//
//  Created by Pranav Bhandari on 4/28/18.
//  Copyright © 2018 Pranav Bhandari. All rights reserved.
//

import UIKit
import CoreMotion

class StepModel {
    var stepData = [CMPedometerData]()

    var days:[String] = []
    var daysArr = [Date]()
    let pedoMeter = CMPedometer()
    
    
    func getStepData(completion: @escaping ([CMPedometerData]) -> ()) {
        let cal = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        var date = cal.startOfDay(for: Date())
        
        for i in 1 ... 10 {
            if i == 1 {
                date = cal.date(byAdding: .day, value: 0, to: date)!
            } else {
                date = cal.date(byAdding: .day, value: -1, to: date)!
            }
            
            daysArr.append(date)
            staticDateArray = daysArr
        }
        for i in 0..<daysArr.count {
            if(CMPedometer.isStepCountingAvailable()){
                let toDate = cal.date(byAdding: .day, value: 1, to: daysArr[i])
                
                self.pedoMeter.queryPedometerData(from: daysArr[i], to: toDate!) { (data : CMPedometerData!, error) -> Void in
                    
                    if(error == nil){
                        
                        self.stepData.append(data)
                        if self.daysArr[i] == self.daysArr[self.daysArr.count - 1] {
                            for _ in 0..<2 {
                                staticStepCounts.append(String(arc4random_uniform(2150) + 900))
                                staticDistanceCounts.append(String(arc4random_uniform(2150) + 900))
                                staticFloorsAscended.append(Int(arc4random_uniform(5) + 1))
                                staticFloorsDescended.append(Int(arc4random_uniform(5) + 1))
                            }
                            
                            completion(self.stepData)
                        }
                    }
                    
                    
                }
            } else {
                staticStepCounts.append(String(arc4random_uniform(5000) + 500))
                staticDistanceCounts.append(String(arc4random_uniform(4000) + 300))
                staticAvgPaceCounts.append(Double(arc4random()) / arc4randoMax * (1.0) + 0.7)
                let floorsAscended = Int(arc4random_uniform(3) + 1)
                staticFloorsAscended.append(floorsAscended)
                staticFloorsDescended.append(4 - floorsAscended)
                
                if i == daysArr.count - 1 {
                    let tmpData = [CMPedometerData]()
                    completion(tmpData)
                }
                
            }
        }
    }
}
