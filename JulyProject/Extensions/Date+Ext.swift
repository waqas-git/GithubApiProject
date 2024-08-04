//
//  Date+Ext.swift
//  JulyProject
//
//  Created by waqas ahmed on 01/08/2024.
//

import Foundation
extension Date{
    
    func convertToMonthYearFormate()-> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
