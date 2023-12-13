//
//  WebViewController.swift
//  KpjhWebApp
//
//  Created by sumwb on 12/13/23.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

  // MARK: - Override Computed Properties
  
  // 상태바 (다크모드일 때 색상으로)
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .darkContent
  }
  
  // MARK: - Properties
  
  let backgroundColor = UIColor(red: 244 / 255, green: 244 / 255, blue: 249 / 255, alpha: 1)
  
  // MARK: - UI Properties
  
  var webView: WKWebView!
  
  // MARK: - LifeCycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.

    // navigation bar hidden
    navigationController?.navigationBar.isHidden = true
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setWebView()
    setLayout()
  }
  
  // MARK: - Methods
  
  // 레이아웃 세팅
  private func setLayout() {
    // 화면 백그라운드 색상
    view.backgroundColor = backgroundColor
    
    // AutoLayout 사용가능하게
    webView.translatesAutoresizingMaskIntoConstraints = false
    
    // 메인 뷰에 등록
    view.addSubview(webView)
    
    // 레이아웃 설정
    NSLayoutConstraint.activate([
      webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
  
  // 웹뷰 세팅
  private func setWebView() {
    // 웹뷰 세부 설정 클래스
    let webConfiguration = WKWebViewConfiguration()
    
    // User-Agent 변경
    webConfiguration.applicationNameForUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/600.7.12 (KHTML, like Gecko) Version/8.0.7 Safari/600.7.12 iphone"
    
    // JavaScript 사용여부 설정
    webConfiguration.preferences.javaScriptEnabled = true
    
    // 웹뷰 인스턴스 생성
    webView = WKWebView(frame: .zero, configuration: webConfiguration)
    
    // 웹뷰 delegate 설정
    webView.navigationDelegate = self
    webView.uiDelegate = self
    
    Log.d(webView.configuration.applicationNameForUserAgent)
    
    
    webView.allowsBackForwardNavigationGestures = true
    
    // 웹뷰 로드
    
    // urlString 변수에 사용할 url 입력(* 전송 프로토콜 붙여야 함 - http or https)
    let urlString = "https://www.google.com/"
    Log.d("urlString : \(urlString)")
    if let url = URL(string: urlString) {
      let request = URLRequest(url: url)
      webView.load(request)
    }
  }
  
  private func showAlert(message: String, completion: (() -> Void)? = nil) {
    let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "확인", style: .default) { _ in
      completion?()
    }
    alert.addAction(action)
    DispatchQueue.main.async {
      self.present(alert, animated: true)
    }
  }
}


// MARK: - WKNavigation Delegate

extension WebViewController: WKNavigationDelegate {
  
  
  func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
    Log.d("WebView failed with error: \(error.localizedDescription)")
    showAlert(message: error.localizedDescription)
  }
  
  func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
    Log.d("WebView navigation failed with error: \(error.localizedDescription)")
    showAlert(message: error.localizedDescription)
  }
  
  func webView(_ webView: WKWebView, didFailLoadWithError error: Error) {
    Log.d("WebView failed to load with error: \(error.localizedDescription)")
    showAlert(message: error.localizedDescription)
  }
  func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
    if let response = navigationResponse.response as? HTTPURLResponse {
      let statusCode = response.statusCode
      Log.d("response.statusCode : \(statusCode)")
      if statusCode != 200 {
        showAlert(message: "현재 운영중인 상태가 아닙니다.😉\nstatus code : \(statusCode)") {
          exit(0)
        }
      }
    }
    decisionHandler(.allow)
  }
  func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    // Check if the navigation action is a link click
    if navigationAction.navigationType == .linkActivated {
      // Open links with target="_blank" in a new tab
      if let targetFrame = navigationAction.targetFrame, targetFrame.isMainFrame {
        // The link has a target frame, so open it in the current webview
        decisionHandler(.allow)
      } else {
        // The link does not have a target frame, so open it in a new tab
        webView.load(navigationAction.request)
        decisionHandler(.cancel)
      }
    } else {
      // Allow other types of navigation actions
      decisionHandler(.allow)
    }
  }
}

// MARK: - WKUI Delegate

extension WebViewController: WKUIDelegate {
  // JavaScript alert()
  func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
    let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
    present(alert, animated: true)
    completionHandler()
  }
  // JavaScript confirm()
  func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
    let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
    
    alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { (action) in
      completionHandler(true)
    }))
    
    alertController.addAction(UIAlertAction(title: "취소", style: .default, handler: { (action) in
      completionHandler(false)
    }))
    
    present(alertController, animated: true)
  }
}
