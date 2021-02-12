//
//  StepDetailsViewController.swift
//  UnderArmourStepTracker
//
//  Created by Pranav Bhandari on 4/30/18.
//  Copyright © 2018 Pranav Bhandari. All rights reserved.
//

import UIKit
import Charts

class StepDetailsViewController: UIViewController {

    @IBOutlet weak var stepChangeLbl: UILabel!
    @IBOutlet weak var stepCountLbl: UILabel!
    @IBOutlet weak var summaryView: UIView!
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var paceLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    
    var indexPath : IndexPath!
    var stepViewModel : StepViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = stepViewModel.getDate(dateForIndexPath: indexPath)
        setupUI()
        chart()
    }
    
    func setupUI() {
        summaryView.layer.cornerRadius = 8
        distanceLbl.text = String(stepViewModel.getDistanceForDay(indexPath: indexPath))
        paceLbl.text = String(format: "%.2f", stepViewModel.getPaceForDay(indexPath: indexPath))
        
        let currentStepCount = stepViewModel.getStepCount(indexPath: indexPath)
        var previousStepCount = "1500"
        let index = IndexPath(row: indexPath.row + 1, section: 0)
        if indexPath.row < 9 {
            previousStepCount = stepViewModel.getStepCount(indexPath: index)
        }
        
        stepCountLbl.text = currentStepCount
        let change = String(Int(currentStepCount)! - Int(previousStepCount)!)
        
        if Int(change)! < 0 {
            stepChangeLbl.text = change
        } else {
            stepChangeLbl.text = "+\(change)"
        }
        
    }
}

//MARK: - Pie Chart
extension StepDetailsViewController {
    func chart() {
        
        let flightsAscended = PieChartDataEntry()
        let flightsDescended = PieChartDataEntry()
        
        var numberOfDataEntries = [PieChartDataEntry]()
        
        
        pieChartView.chartDescription?.text = ""
        
        flightsAscended.value = Double(stepViewModel.getFloorAscended(indexPath: indexPath))
        flightsAscended.label = "Ascended"
        flightsDescended.value = Double(stepViewModel.getFloorDescended(indexPath: indexPath))
        flightsDescended.label = "Descended"
        
        numberOfDataEntries = [flightsAscended, flightsDescended]
        
        let chartDataSet = PieChartDataSet(values: numberOfDataEntries, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        let colors = [UIColor(red: 255/255.0, green: 81/255.0, blue: 79/255.0, alpha: 1), UIColor(red: 0/255.0, green: 225/255.0, blue: 165/255.0, alpha: 1)]
        chartDataSet.colors = colors as [NSUIColor]
        
        pieChartView.data = chartData
        
    }
}
