//
//  MainTabController.swift
//  HSB
//
//  Created by JW Moon on 2021/12/17.
//

import UIKit

class MainTabController: UITabBarController {
    
    // MARK: - Properties
    
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()

    }
    
    
    // MARK: - Helpers
    
    func configureViewControllers() {
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = .systemGray6
        self.tabBar.standardAppearance = appearance
        self.tabBar.scrollEdgeAppearance = appearance
        self.tabBar.setValue(UIColor.black, forKey: "tintColor")

        let faceCheck = FaceCheckViewController()
        let nav1 = createNavigationController(image: UIImage(systemName: "checkmark"), title: "교문 지도", rootViewController: faceCheck)
        
        let studentList = StudentListViewController()
        let nav2 = createNavigationController(image: UIImage(systemName: "doc.text"), title: "지도 명단", rootViewController: studentList)
        
        let guidanceManage = GuidanceManageController()
        let nav3 = createNavigationController(image: UIImage(systemName: "pencil"), title: "봉사 지도", rootViewController: guidanceManage)
        
        self.viewControllers = [nav1, nav2, nav3]
    }
    
    func createNavigationController(image: UIImage?, title: String, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.tabBarItem.title = title
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = .lightGray
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 25)]
        
        let bar = nav.navigationBar
        bar.standardAppearance = appearance
        bar.compactAppearance = appearance
        bar.scrollEdgeAppearance = appearance
        
        bar.overrideUserInterfaceStyle = .dark
        
        return nav
    }
}
