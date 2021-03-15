//
//  TutorialMasterViewController.swift
//  MemoApp
//
//  Created by MyeongJin on 2021/03/15.
//

import UIKit

class TutorialMasterViewController: UIViewController, UIPageViewControllerDataSource {

    
    var pageVC: UIPageViewController!
    
    // 콘텐츠 뷰 컨트롤러에 들어갈 타이틀과 이미지
    var contentTitles = [
        "STEP 1",
        "STEP 2",
        "STEP 3",
        "STEP 4"
    ]
    var contentImages = [
        "Page0",
        "Page1",
        "Page2",
        "Page3"
    ]
    
    @IBAction func close(_ sender: Any) {
        let ud = UserDefaults.standard
        ud.set(true, forKey: UserInfoKey.tutorial)
        ud.synchronize()
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func getContentVC(atIndex idx: Int) -> UIViewController? {
        // 인덱스가 데이터 배열 크기 범위를 벗어나면 nii
        guard self.contentTitles.count >= idx && self.contentTitles.count > 0 else {
            return nil
        }
        
        // "ContentsVC"라는 Storyboard ID를 가진 뷰 컨트롤러의 인스턴스를 생성하고 캐스팅
        guard  let contentsVC = self.instanceTutorialVC(name: "ContentsVC") as? TutorialContentsViewController else {
            return nil
        }
        
        // 콘텐츠 뷰 컨트롤러의 내용 구성
        contentsVC.titleText = self.contentTitles[idx]
        contentsVC.imageFile = self.contentImages[idx]
        contentsVC.pageIndex = idx
        
        return contentsVC
    }
    
    // 현재의 콘텐츠 뷰 컨트롤러보다 앞쪽에 올 콘텐츠 뷰 컨트롤러 객체
    // 즉, 현재의 상태에서 앞쪽으로 스와이프
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        //현재 페이지 인덱스
        guard var index = (viewController as! TutorialContentsViewController).pageIndex else {
            return nil
        }
        
        // 현재의 인덱스가 맨 앞이라면 nil
        guard index > 0 else {
            return nil
        }
        index -= 1 // 현재 인덱스에서 하나 뺌
        return self.getContentVC(atIndex: index)
    }
    
    // 현재의 콘텐츠 뷰 컨트롤러보다 뒤쪽에 올 콘텐츠 뷰 컨트롤러 객체
    // 즉, 현재의 상태에서 뒤쪽으로 스와이프
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        //현재 페이지 인덱스
        guard var index = (viewController as! TutorialContentsViewController).pageIndex else {
            return nil
        }
        
        index += 1 // 현재 인덱스에서 하나 더함
        
        // 인덱스는 배열의 크기보다 작아야함
        guard index < self.contentTitles.count else {
            return nil
        }
        
        return self.getContentVC(atIndex: index)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 1. 페이지 뷰 컨트롤러 객체 생성
        self.pageVC = self.instanceTutorialVC(name: "PageVC") as? UIPageViewController
        self.pageVC.dataSource = self
        
        // 2. 페이지 뷰 컨트롤러의 기본 페이지 지정
        let startContentVC = self.getContentVC(atIndex: 0)!
        self.pageVC.setViewControllers([startContentVC], direction: .forward, animated: true, completion: nil)
        
        // 3. 페이지 뷰 컨트롤러의 출력 영역 지정
        self.pageVC.view.frame.origin = CGPoint(x: 0, y: 0)
        self.pageVC.view.frame.size.width = self.view.frame.width
        self.pageVC.view.frame.size.height = self.view.frame.height - 50
        
        // 4. 페이지 뷰 컨트롤러를 마스터 뷰 컨트롤러의 자식 뷰 컨트롤러로 설정
        self.addChild(self.pageVC)
        self.view.addSubview(self.pageVC.view)
        self.pageVC.didMove(toParent: self)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.contentTitles.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
