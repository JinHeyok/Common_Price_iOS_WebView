//
//  ViewController.swift
//  KpjhWebApp
//
//  Created by sumwb on 12/13/23.
//

import UIKit
import WebKit

class ViewController: UIViewController {
  
  // MARK: - Properties
  
  var timer = Timer()
  
  var totalTime: Float = 1.5
  var currentTime: Float = 0.0
  
  // MARK: - UI Properties
  
  let imageView = UIImageView(image: UIImage(resource: .logo01))
  
  // MARK: - LifeCycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setLayout()
    startTimer()
  }
  
  // MARK: - Methods
  
  // 레이아웃 세팅
  private func setLayout() {
    // 화면 백그라운드 색상
    view.backgroundColor = .white
    
    // AutoLayout 사용가능하게
    imageView.translatesAutoresizingMaskIntoConstraints = false
    
    // 메인 뷰에 등록
    view.addSubview(imageView)
    
    // 레이아웃 설정
    NSLayoutConstraint.activate([
      imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
      imageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
      imageView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.7)
    ])
    
    // 이미지 비율
    imageView.contentMode = .scaleAspectFit // 이미지가 안깨지는 한 최대로
  }
  
  // 타이머 시작
  private func startTimer() {
    // 타이머 시작하기 전에 초기화
    timer.invalidate()
    currentTime = 0
    
    DispatchQueue.main.async { // 메인 쓰레드에서 비동기로
      /* node에선
       setInterval(function() {
        self.updateTimer
       }, 0.5초)
       */
      self.timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
    }
  }
  
  // MARK: - @objc Methods
  
  @objc func updateTimer() {
    if currentTime < totalTime {
      currentTime += 0.5
    } else {
      // 타이머 종료
      timer.invalidate()
      
      // 다음 화면으로 이동
      let rootVC = WebViewController()
      if let navController = self.navigationController {
        rootVC.modalTransitionStyle = .partialCurl
        navController.viewControllers.removeAll()
        navController.setViewControllers([rootVC], animated: true)
      }
      
    }
  }
}
