//
//  BarChart.swift
//  UnderArmourStepTracker
//
//  Created by Pranav Bhandari on 4/30/18.
//  Copyright © 2018 Pranav Bhandari. All rights reserved.
//

import UIKit
import Charts

class LineChart: UIView {
    
    //Line graph Properies
    let lineChartView = LineChartView()
    var lineDataEntry : [ChartDataEntry] = []
    
    //chart data
    var date = [String]()
    var steps = [String]()
    
    var delegate: GetChartData! {
        didSet {
            populateData()
            lineChartSetup()
        }
    }
    
    func populateData() {
        date = delegate.date
        steps = delegate.steps
    }
    
    func lineChartSetup() {
        //set line chart config
        self.addSubview(lineChartView)
        lineChartView.translatesAutoresizingMaskIntoConstraints = false
        lineChartView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        lineChartView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        lineChartView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        lineChartView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        
        //line chart animator
        lineChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInSine)
        
        //line chart population
        setLineChart(dataPoints: date, values: steps)
    }
    
    func setLineChart(dataPoints: [String], values: [String]) {
        // No data Setup
        lineChartView.noDataTextColor = UIColor.red
        lineChartView.noDataText = "No Data Available"
        
        //Data point setup and color config
        for i in 0..<dataPoints.count {
            let dataPoint = ChartDataEntry(x: Double(i), y: Double(values[i])!)
            lineDataEntry.append(dataPoint)
        }
        
        let chartDataSet = LineChartDataSet(values: lineDataEntry, label: "Steps")
        lineChartView.legend.textColor = UIColor.white
        let chartData = LineChartData()
        chartData.addDataSet(chartDataSet)
        chartData.setDrawValues(true)
        chartData.setValueTextColor(UIColor.white as NSUIColor)
        
        chartDataSet.colors = [UIColor.white]
        chartDataSet.setCircleColor(UIColor.white)
        chartDataSet.circleHoleColor = UIColor.white
        chartDataSet.circleRadius = 4.0
        
        //gradient fill
        let gradientColors = [UIColor.white.cgColor, redColor.cgColor] as CFArray
        let colorLocations: [CGFloat] = [1.0,0.0]
        guard let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) else {
            print("gradient error")
            return
        }
        chartDataSet.fill = Fill.fillWithLinearGradient(gradient, angle: 90.0)
        chartDataSet.drawFilledEnabled = true
        
        lineChartView.leftAxis.labelTextColor = UIColor.white
        lineChartView.xAxis.labelTextColor = UIColor.white
        
        //axes setup
        let formatter: ChartFormatter = ChartFormatter()
        formatter.setValues(dataPoints)
        let xaxis : XAxis = XAxis()
        xaxis.valueFormatter = formatter as IAxisValueFormatter
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.xAxis.valueFormatter = xaxis.valueFormatter
        lineChartView.chartDescription?.enabled = false
        lineChartView.legend.enabled = true
        lineChartView.rightAxis.enabled = false
        lineChartView.leftAxis.drawGridLinesEnabled = false
        lineChartView.leftAxis.drawLabelsEnabled = true
        lineChartView.data = chartData
    }

}
