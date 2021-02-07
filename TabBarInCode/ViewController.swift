//
//  ViewController.swift
//  TabBarInCode
//
//  Created by 王凯霖 on 2/7/21.
//

import UIKit

class ViewController: UIViewController {
    
    let button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        button.setTitle("登录", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        view.addSubview(button)
        button.center = view.center
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc func didTapButton(){
        let tabBarVC = UITabBarController()

        let vc1 = UINavigationController(rootViewController: FirstViewController())
        let vc2 = UINavigationController(rootViewController: SecondViewController())
        let vc3 = UINavigationController(rootViewController: ThirdViewController())

        vc1.title = "主页"
        vc2.title = "联系人"
        vc3.title = "帮助"

        tabBarVC.setViewControllers([vc1, vc2, vc3], animated: false)

        guard let items = tabBarVC.tabBar.items else{
            return
        }

        let imgList = ["house", "person.circle", "gear"]

        for index in 0..<imgList.count {
            items[index].image = UIImage(systemName: imgList[index])
        }

        tabBarVC.modalPresentationStyle = .fullScreen
        present(tabBarVC, animated: true)
    }
    
    
    class FirstViewController: UIViewController {
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .systemIndigo
            title = "主页"
        }
    }
    
    class SecondViewController: UIViewController {
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .systemOrange
            title = "联系人"
        }
    }
    
    class ThirdViewController: UIViewController {
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .systemBlue
            title = "帮助"
        }
    }

}

