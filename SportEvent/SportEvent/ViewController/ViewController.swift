import Foundation
import UIKit
import Alamofire

class ViewController: UIViewController, UIScrollViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let tabBarViewController = UITabBarController()
        let sportEventViewController = SportEventViewController()
        let favoritesViewController = FavoritesViewController()
        
        sportEventViewController.tabBarItem = .init(title: "Events", image: UIImage(systemName: "sportscourt"), selectedImage: nil)
        favoritesViewController.tabBarItem = .init(title: "Favorites", image: UIImage(systemName: "heart"), selectedImage: nil)
        tabBarViewController.setViewControllers([sportEventViewController, favoritesViewController], animated: false)
        tabBarViewController.modalPresentationStyle = .fullScreen
        present(tabBarViewController, animated: false)
    }
    
}
