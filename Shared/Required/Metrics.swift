//
//  Metrics.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/18/22.
//

import Foundation

let kDayMetrics = "Vaif R2 - VPN: DayMetrics"
let kWeekMetrics = "Vaif R2 - VPN: WeekMetrics"
let kTotalMetrics = "Vaif R2 - VPN: TotalMetrics"

let kActiveDay = "Vaif R2 - VPN: ActiveDay"
let kActiveWeek = "Vaif R2 - VPN: ActiveWeek"

func getDayMetrics() -> Int {
    return defaults.integer(forKey: kDayMetrics)
}

func getDayMetricsString(commas: Bool = false) -> String {
    return metricsToString(metric: getDayMetrics(), commas: commas)
}

func getWeekMetrics() -> Int {
    return defaults.integer(forKey: kWeekMetrics)
}

func getWeekMetricsString() -> String {
    return metricsToString(metric: getWeekMetrics())
}

func getTotalMetrics() -> Int {
    return defaults.integer(forKey: kTotalMetrics)
}

func getTotalMetricsString() -> String {
    return metricsToString(metric: getTotalMetrics())
}

func metricsToString(metric : Int, commas: Bool = false) -> String {
    if (commas) {
        let commasFormatter = NumberFormatter()
        commasFormatter.numberStyle = .decimal
        guard let formattedNumber = commasFormatter.string(from: NSNumber(value: metric)) else { return "\(metric)" }
        return formattedNumber
    }
    if metric < 1000 {
        return "\(metric)"
    }
    else if metric < 1000000 {
        return "\(Int(metric / 1000))k"
    }
    else {
        return "\(String(format: "%.2f", (Double(metric) / Double(1000000))))m"
    }
}

enum Metrics {
    
}

