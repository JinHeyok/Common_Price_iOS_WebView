//
//  Logger.swift
//  KpjhWebApp
//
//  Created by sumwb on 12/13/23.
//

import Foundation

enum LogEvent: String {
  case e = "[‼️]" // 오류
  case i = "[ℹ️]" // 정보
  case d = "[💬]" // 디버그
  case v = "[🔬]" // 상세
  case w = "[⚠️]" // 경고
  case s = "[🔥]" // 심각함
}

class Log {
  private static var dateFormat = "yyyy-MM-dd hh:mm:ssSSS"
  private static var isLoggingEnabled: Bool {
  #if DEBUG
    return true
  #else
    return false
  #endif
  }
  
  private class func sourceFileName(filePath: String) -> String {
    let components = filePath.components(separatedBy: "/")
    return components.isEmpty ? "" : components.last!
  }
  
  class func e(_ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
    if isLoggingEnabled {
      print("\n\(Date().toString(dateFormat)) \(LogEvent.e.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)")
    }
  }
  
  class func i(_ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
    if isLoggingEnabled {
      print("\n\(Date().toString(dateFormat)) \(LogEvent.i.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)")
    }
  }
  
  class func d(_ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
    if isLoggingEnabled {
      print("\n\(Date().toString(dateFormat)) \(LogEvent.d.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)")
    }
  }
  
  class func v(_ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
    if isLoggingEnabled {
      print("\n\(Date().toString(dateFormat)) \(LogEvent.v.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)")
    }
  }
  
  class func w(_ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
    if isLoggingEnabled {
      print("\n\(Date().toString(dateFormat)) \(LogEvent.w.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)")
    }
  }
  
  class func s(_ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
    if isLoggingEnabled {
      print("\n\(Date().toString(dateFormat)) \(LogEvent.s.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)")
    }
  }
}

func print(_ object: Any) {
#if DEBUG
  Swift.print(object)
#endif
}
