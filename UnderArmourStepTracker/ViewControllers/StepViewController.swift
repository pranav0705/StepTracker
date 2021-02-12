//
//  StepViewController.swift
//  UnderArmourStepTracker
//
//  Created by Pranav Bhandari on 4/27/18.
//  Copyright © 2018 Pranav Bhandari. All rights reserved.
//

import UIKit
import CoreMotion
import Charts


protocol GetChartData {
    func getChartData(with dataPoints: [String], values: [String])
    var date: [String] {get set}
    var steps: [String] {get set}
}

class StepViewController: UIViewController {
    
    
    @IBOutlet weak var chartView: LineChart!
    @IBOutlet weak var summaryView: UIView!
    @IBOutlet weak var avgPace: UILabel!
    @IBOutlet weak var totalDistance: UILabel!
    @IBOutlet weak var totalSteps: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //Chart Data
    var date = [String]()
    var steps = [String]()
    
    let activityManager = CMMotionActivityManager()
    let pedoMeter = CMPedometer()
    
    let stepViewModel = StepViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stepViewModel.fetchStepData {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.setupSummaryView()
                self.populateChartData()
                self.lineChart()
            }
        }
        
     }
    
    func setupSummaryView() {
        summaryView.layer.cornerRadius = 8
        chartView.layer.cornerRadius = 8
        chartView.layer.masksToBounds = true
        totalSteps.text = String(stepViewModel.getStepCountSummary())
        totalDistance.text = String(stepViewModel.getTotalDistance())
        avgPace.text = String(format: "%.2f", stepViewModel.getAvgPace()) //String()
    }

}

//MARK: - Table view functions
extension StepViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stepViewModel.numberofItemsinSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StepDays") as! Home_StepTableViewCell
        
        cell.configureCell(cell: cell, cellForRowAt: indexPath, stepCount: stepViewModel.getStepCount(indexPath: indexPath), date: stepViewModel.getDate(dateForIndexPath: indexPath))
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stepDetailsSegue" {
            let indexPath = tableView.indexPathForSelectedRow
            let stepDetailsViewController = segue.destination as! StepDetailsViewController
            stepDetailsViewController.indexPath = indexPath
            stepDetailsViewController.stepViewModel = stepViewModel
        }
    }
    
    
}

//MARK: - Charts
extension StepViewController: GetChartData {
    
    func populateChartData() {
        date = stepViewModel.getDateArray()
        steps = stepViewModel.getStepCountArray()
        self.getChartData(with: date, values: steps)
    }
    
    func getChartData(with dataPoints: [String], values: [String]) {
        self.date = dataPoints
        self.steps = values
    }
    
    func lineChart() {
        let lineChart = LineChart(frame: CGRect(x: 0.0, y: 0.0, width: chartView.frame.width, height: chartView.frame.height))
        lineChart.delegate = self
        chartView.addSubview(lineChart)
    }
}




