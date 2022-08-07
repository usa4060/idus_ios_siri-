import XLPagerTabStrip
import UIKit

class LikesViewController: ButtonBarPagerTabStripViewController {
    
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    
    override func viewDidLoad() {
        self.configureButtonBar()
        super.viewDidLoad()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let child1 = LikeProductViewController()
        let child2 = LikeOnlineViewController()
        let child3 = LikeOfflineClassViewController()
        return [child1, child2, child3]
        
    }
    
    private func configureButtonBar() {
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        
        settings.style.buttonBarItemFont = UIFont(name: "Helvetica", size: 14.0)!
        settings.style.buttonBarItemTitleColor = .gray
        
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        
        settings.style.selectedBarHeight = 2.0
        settings.style.selectedBarBackgroundColor = .mainOrange
        
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .gray
            oldCell?.label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
            newCell?.label.textColor = .mainOrange
            newCell?.label.font = UIFont.systemFont(ofSize: 14.0, weight: .bold)
            
        }
    }
    

    @IBAction func dissmissBtnTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}
