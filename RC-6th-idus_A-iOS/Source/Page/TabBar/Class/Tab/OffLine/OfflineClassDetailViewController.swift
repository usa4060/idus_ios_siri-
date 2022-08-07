//
//  OfflineClassDetailViewController.swift
//  RC-6th-idus_A-iOS
//
//  Created by admin on 2022/07/13.
//

import UIKit

class OfflineClassDetailViewController: UIViewController {

    @IBOutlet weak var classImg: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var offClassTitle: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var timeSpend: UILabel!
    @IBOutlet weak var maxCapacity: UILabel!
    @IBOutlet weak var likeLayer: UIStackView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        OfflineClassDetatilDataManager().requireOfflineClassDetail(Constant.selectedOfflineClass, self) { data in
            Constant.offlineClassDatailResult = data
            self.layoutConfiguration()
        }
    }


    
    private func layoutConfiguration(){
        let url = URL(string: "https://\(Constant.offlineClassDatailResult.classImgList[0])")
        self.classImg.kf.setImage(with: url){
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        classImg.contentMode = .scaleAspectFill
        likeLayer.layer.borderWidth = 1
        likeLayer.layer.borderColor = UIColor.lightGray.cgColor
        likeLayer.layer.masksToBounds = true
        likeLayer.layer.cornerRadius = 4
        
        let item = Constant.offlineClassDatailResult
        
        offClassTitle.text = item.title
        price.text = "\(item.price)"
        level.text = item.level
        timeSpend.text = item.timeSpend
        maxCapacity.text = item.maxCapacity
        
    }
    @IBAction func dismissBtnTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
