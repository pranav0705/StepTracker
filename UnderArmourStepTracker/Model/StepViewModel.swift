//
//  StepViewModel.swift
//  UnderArmourStepTracker
//
//  Created by Pranav Bhandari on 4/28/18.
//  Copyright © 2018 Pranav Bhandari. All rights reserved.
//

import UIKit
import CoreMotion

class StepViewModel {

    let stepModel = StepModel()
    var stepData = [CMPedometerData]()
    
    
    func fetchStepData(completion: @escaping () -> ()) {
        stepModel.getStepData { stepData in
            self.stepData = stepData
            completion()
        }
    }
    
    func numberofItemsinSection(section: Int) -> Int {
        
        return stepData.count > 0 ? stepData.count : staticStepCounts.count
    }
    
    func getStepCount(indexPath: IndexPath) -> String {
        
        guard isStepDataAvailable() else {
            return staticStepCounts[indexPath.row]
        }
        
        let count = stepData[indexPath.row].numberOfSteps as! Int
        
        return count != 0 ? String(count) : staticStepCounts[indexPath.row % 8]
    }
    
    func getDate(dateForIndexPath: IndexPath) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"
        
        guard isStepDataAvailable() else {
            return dateFormatter.string(from: staticDateArray[dateForIndexPath.row])
        }
        return dateFormatter.string(from: stepData[dateForIndexPath.row].endDate)
    }
    
    func getStepCountSummary() -> Int {
        var totalSteps = 0
        guard isStepDataAvailable() else {
            for count in staticStepCounts {
                totalSteps += Int(count)!
            }
            return totalSteps
        }
        
        for i in 0..<stepData.count {
            totalSteps += Int(truncating: stepData[i].numberOfSteps)
            
            if i >= 8 {
                totalSteps += Int(staticStepCounts[i % 8])!
            }
            
        }
        return totalSteps
    }
    
    func getStepCountArray() -> [String] {
        var stepCountArray = [String]()
        
        guard isStepDataAvailable() else {
            return staticStepCounts
        }
        
        for i in 0..<stepData.count {
            stepCountArray.append(String(Int(truncating: stepData[i].numberOfSteps)))
            
            if i >= 8 {
                stepCountArray[i] = staticStepCounts[i % 8]
            }
            
        }
        
        return stepCountArray
    }
    
    func getDateArray() -> [String] {
        
        var dateArray = [String]()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"
        
        guard isStepDataAvailable() else {
            for date in staticDateArray {
                dateArray.append(dateFormatter.string(from: date))
            }
            return dateArray
        }
        
        for i in 0..<stepData.count {
            dateArray.append(dateFormatter.string(from: stepData[i].endDate))
        }
        return dateArray
    }
    
    func getTotalDistance() -> Int {
        var totalDistance = 0
        
        guard isStepDataAvailable() else {
            for distance in staticDistanceCounts {
                totalDistance += Int(distance)!
            }
            
            return totalDistance
        }
        
        for i in 0..<stepData.count {
            totalDistance += Int(truncating: stepData[i].distance!)
            
            if i >= 8 {
                totalDistance += Int(staticDistanceCounts[i % 8])!
            }
            
        }
        
        return totalDistance
    }
    
    func getAvgPace() -> Double {
        var avgPace = 0.0
        
        guard isStepDataAvailable() else {
            for pace in staticAvgPaceCounts {
                avgPace += pace
            }
            return avgPace/10.0
        }
        
        for i in 0..<stepData.count {
            if let pace = stepData[i].averageActivePace {
                avgPace += Double(truncating: pace)
                if i >= 8 {
                    avgPace += 1.3
                }
            }
            
        }
        
        return avgPace/10.0
    }
    
    func getDistanceForDay(indexPath: IndexPath) -> Int {
        
        guard isStepDataAvailable() else {
            return Int(staticDistanceCounts[indexPath.row])!
        }
        
        if indexPath.row >= 8 {
            return Int(staticDistanceCounts[indexPath.row % 8])!
        }
        
        return Int(truncating: stepData[indexPath.row].distance!)
    }
    
    func getPaceForDay(indexPath: IndexPath) -> Double {
        
        guard isStepDataAvailable() else {
            return staticAvgPaceCounts[indexPath.row]
        }
        
        if let pace = stepData[indexPath.row].averageActivePace {
            return Double(truncating: pace)
        }
        
        return 1.3
    }
    
    
    func getFloorAscended(indexPath: IndexPath) -> Int {
        guard isStepDataAvailable() else {
            return staticFloorsAscended[indexPath.row]
        }
        
        if indexPath.row >= 8 {
            return staticFloorsAscended[indexPath.row % 8]
        }
        
        let count = Int(truncating: stepData[indexPath.row].floorsAscended!)
        
        return count == 0 ? 1 : count
    }
    
    func getFloorDescended(indexPath: IndexPath) -> Int {
        guard isStepDataAvailable() else {
            return staticFloorsDescended[indexPath.row]
        }
        
        if indexPath.row >= 8 {
            return staticFloorsDescended[indexPath.row % 8]
        }
        
        return Int(truncating: stepData[indexPath.row].floorsDescended!)
    }
    
    
    //Useful when running on a simulator
    func isStepDataAvailable() -> Bool {
        guard stepData.count > 0 else {
            return false
        }
        
        return true
    }
    
    
    
    
}
