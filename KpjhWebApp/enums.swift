//
//  enums.swift
//  KpjhWebApp
//
//  Created by sumwb on 12/13/23.
//

import Foundation

public enum Environment {
  enum Keys {
    enum Plist {
      static let webViewURL = "WEBVIEW_URL"
    }
  }
  
  private static let infoDictionary: [String: Any]? = {
    let dict = Bundle.main.infoDictionary
    return dict
  }()
  
  static let webViewURL: String? = {
    let webViewURL = Environment.infoDictionary?[Keys.Plist.webViewURL] as? String
    return webViewURL
  }()
}
