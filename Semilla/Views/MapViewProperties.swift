//
//  MapViewProperties.swift
//  Semilla
//
//  Created by Netset on 14/12/23.
//

import UIKit
import GoogleMaps

class MapViewProperties: UIView,GMSMapViewDelegate {
    
    //MARK: IBOutlet's
    @IBOutlet weak var vwArrivingTime: UIView!
    @IBOutlet weak var vwMap: UIView!
    @IBOutlet weak var lblEstimatedTimeDigit: UILabel!
    @IBOutlet weak var lblEstimatedTimeMins: UILabel!
    @IBOutlet weak var vwDriverDetails: UIView!
    @IBOutlet weak var lblDriverDetails: UILabel!
    @IBOutlet weak var imgVwDriverImage: UIImageView!
    @IBOutlet weak var lblDriverName: UILabel!
    @IBOutlet weak var lblDriverId: UILabel!
    @IBOutlet weak var cnstVwHeightDriverDetails: NSLayoutConstraint!
    @IBOutlet weak var lblDriverAssigned: UILabel!
    @IBOutlet weak var vwDriverAssigned: UIView!
    @IBOutlet weak var imgVwDeliveryScooter: UIImageView!
    @IBOutlet weak var btnOrderHistory: UIButton!
    @IBOutlet weak var vwOTP: UIView!
    @IBOutlet weak var lblOTP: UILabel!
    
    // MARK: Variable Declaration
    var objMapViewDelegates: DelegatesMapView?
    var mapView: GMSMapView!
    
    // MARK: View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async { [self] in
            let camera = getCameraPosition(lat: userCurrentLat, long: userCurrentLong, zoom: 14)
            mapView = GMSMapView(frame: CGRect(x: 0, y: 0, width: vwMap.frame.size.width, height: vwMap.frame.size.height), camera: camera)
            vwMap.addSubview(mapView)
            mapView.delegate = self
            vwDriverDetails.alpha = 0
            cnstVwHeightDriverDetails.constant = 0
        }
        //handleSwipeGaustureMethod()
    }
    
    //MARK: IBAction's
    @IBAction func actionBtnBack(_ sender: UIButton) {
        self.objMapViewDelegates?.gotoBack()
    }
    
    @IBAction func actionBtnCall(_ sender: UIButton) {
        self.objMapViewDelegates?.callNumber()
    }
    
    @IBAction func actionBtnViewOrderHistory(_ sender: UIButton) {
        self.objMapViewDelegates?.goToOrderDetails()
    }
    
    @IBAction func actionBtnNavigateToGoogleMaps(_ sender: UIButton) {
        self.objMapViewDelegates?.goToGoogleMaps()
    }
}

extension MapViewProperties {
    
    func handleSwipeGaustureMethod() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeUp.direction = .up
        vwArrivingTime.addGestureRecognizer(swipeUp)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeDown.direction = .down
        vwArrivingTime.addGestureRecognizer(swipeDown)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case .down:
                print("Swiped down")
                UIView.animate(withDuration: 0.5, delay: 0,options: .curveLinear,animations: { [self] in
                    vwDriverDetails.alpha = 0
                    cnstVwHeightDriverDetails.constant = 0
                    layoutIfNeeded()
                }, completion: nil)
            case .up:
                print("Swiped up")
                UIView.animate(withDuration: 0.5, delay: 0,options: .curveLinear,animations: { [self] in
                    vwDriverDetails.alpha = 1
                    cnstVwHeightDriverDetails.constant = 150
                    layoutIfNeeded()
                }, completion: nil)
            default:
                break
            }
        }
    }
}
