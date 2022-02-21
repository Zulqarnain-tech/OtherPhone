//
//  ViewController.swift
//  OtherPhone
//
//  Created by Zulqarnain on 20/02/2022.
//

import UIKit

class ViewController: UIViewController {

    // Mark: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Mark: - properties
    
    private var joinService = JoinService()
    var receivedArray = [String]()
    var myURL: String?
    var services: NetService?
    
    // Mark: - // Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startBrowsing()
        // Do any additional setup after loading the view.
    }

    
    // Mark: - // Custom Methods
    
    func startBrowsing() {
        joinService.startBrowsing(netServiceBlock: { (netServiceStatus) in
        }, netServiceBrowserBlock: { (netServiceBrowserStatus) in
        }, socketStatusBlock: { (socketStatus, objSocket) in
        }, reloadConnectionsBlock: { (netservices) in
            self.reloadConnections(services: netservices)
        }) { (incomingValue) in
            self.incomingValue(str: incomingValue)
        }
    }
    
    func serviceSelected(service: NetService) {
        joinService.serviceSelected(service: service)
    }
    
    func incomingValue(str: String) {
        if str != "Host_soc" || str != "Join_soc"{
            self.receivedArray.append(str)
        }
    }
    
    func reloadConnections(services: [NetService]) {
        self.services = services[0]
        collectionView.reloadData()
    }
    
    // Mark: - // Action Methods
    @IBAction func retrieveImagesBtnPressed(_ sender: Any) {
        serviceSelected(service: self.services!)
    }
    
    @IBAction func printValueOfStr(_ sender: Any) {
        
        print(": : \(self.receivedArray)")
        var stringRepresentation = self.receivedArray.joined(separator:"")
        print("stringRepresentation : : \(stringRepresentation)")
        
        stringRepresentation.until("jpg")
        self.myURL = stringRepresentation + "jpg"
        self.myURL =  self.myURL?.replacingOccurrences(of: "Host_soc", with: "")
        self.receivedArray.removeAll()
        self.receivedArray.append(self.myURL!)
        self.collectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.receivedArray.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCellIdentifier", for: indexPath) as? ReceivedImageCollectionViewCell else { return UICollectionViewCell() }
        let image = URL(string: self.receivedArray[indexPath.row])!
        cell.shownImage.loadImage(fromURL: image)
        return cell
    }
    
    
}
extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 160)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) //.zero
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


extension String {

    mutating func until(_ string: String) {
        let components = self.components(separatedBy: string)
        self = components[0]
    }

}
