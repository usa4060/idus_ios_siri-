
import UIKit

class OrderListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "OrderListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "OrderListCell")
        
        OrderListDataManager().requireLOrderList(self) { data in
            Constant.orderListResult = data
            print(Constant.orderListResult.count)
            self.collectionView.reloadData()
        }
    
    }
    
    @IBAction func dismissBtnTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

extension OrderListViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constant.orderListResult.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.size.width
        let height = collectionView.bounds.size.height
        
        return CGSize(width: width - 16, height: height / 5.5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = Constant.orderListResult[indexPath.row]
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "OrderListCell", for: indexPath) as! OrderListCollectionViewCell).then{
            $0.prepare(productImg: item.productImg, finalPrice: item.finalPrice, title: item.title, writerName: item.writerName, sendStatus: item.sendStatus, orderAt: item.orderAt)
        }
        return cell
    }
}
