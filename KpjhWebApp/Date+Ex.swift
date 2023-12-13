//
//  Date+Ex.swift
//  KpjhWebApp
//
//  Created by sumwb on 12/13/23.
//

import Foundation

extension Date {
  func toString(_ dateFormat: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ko_KR")
    dateFormatter.dateFormat = dateFormat
    return dateFormatter.string(from: self)
  }
}
