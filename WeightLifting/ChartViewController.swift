//
//  ChartViewController.swift
//  WeightLifting
//
//  Created by Alexander Yakovenko on 2/27/18.
//  Copyright © 2018 Alexander Yakovenko. All rights reserved.
//

import UIKit
import SwiftCharts



class ChartViewController: UIViewController {
    
    var chartView: BarsChart!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let chartConfig = BarsChartConfig(valsAxisConfig: ChartAxisConfig(from: 0, to: 150, by: 10))
        let frame  = CGRect(x: 0, y: 80, width: self.view.frame.width, height: 450)
        
        let chart =  BarsChart(frame: frame, chartConfig: chartConfig, xTitle: "Дата", yTitle: "Вага", bars: [("2", 35),("4", 40), ("5", 45), ("6", 47), ("7", 49), ("8", 60), ("9", 61), ("10", 65)], color: UIColor.blue, barWidth: 15)
        
        self.view.addSubview(chart.view)
        self.chartView = chart
        
    }
}
