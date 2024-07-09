//
//  MainTabBarController.swift
//  KkuMulKum
//
//  Created by YOUJIM on 7/6/24.
//

import UIKit


final class MainTabBarController: UITabBarController {
    
    
    // MARK: - LifeCycles

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBar()
    }
    
    
    // MARK: - Functions
    
    
    private func setTabBar() {
        let homeViewController: HomeViewController = HomeViewController().then {
            $0.tabBarItem.title = "홈"
            $0.tabBarItem.image = .iconHome
        }
        
        let groupListViewController: GroupListViewController = GroupListViewController().then {
            $0.tabBarItem.title = "내 모임"
            $0.tabBarItem.image = .iconGroup
        }
        
        let myPageViewController: MyPageViewController = MyPageViewController().then {
            $0.tabBarItem.title = "마이"
            $0.tabBarItem.image = .iconMy
        }
        
        tabBar.unselectedItemTintColor = .gray2
        tabBar.tintColor = .maincolor
        
        let homeNavigationController = UINavigationController(rootViewController: homeViewController).then {
            $0.navigationBar.topItem?.backButtonDisplayMode = .minimal
            $0.navigationBar.tintColor = .black
        }
        
        let groupListNavigationController = UINavigationController(rootViewController: groupListViewController).then {
            $0.navigationBar.topItem?.backButtonDisplayMode = .minimal
            $0.navigationBar.tintColor = .black
        }
        
        let myPageViewNavigationController = UINavigationController(rootViewController: myPageViewController).then {
            $0.navigationBar.topItem?.backButtonDisplayMode = .minimal
            $0.navigationBar.tintColor = .black
        }
        
        setViewControllers([
            homeNavigationController,
            groupListNavigationController,
            myPageViewNavigationController
        ], animated: true)
    }
}
