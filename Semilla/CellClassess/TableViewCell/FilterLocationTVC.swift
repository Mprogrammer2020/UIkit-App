//
//  FilterLocationTVC.swift
//  Semilla
//
//  Created by Baljinder [iMac] on 29/01/24.
//

import UIKit

class FilterLocationTVC: UITableViewCell {

    //MARK: IBOutlet's
    @IBOutlet weak var sliderVwLocation: UISlider!
    @IBOutlet weak var lblStartingKM: UILabel!
    @IBOutlet weak var lblEndingKM: UILabel!
    @IBOutlet weak var vwSlider: UIView!
    
    var sliderLableP = UILabel()
    var isOpen = Bool()
    var callbackSliderVal:((Int)->())?
    
    //MARK: Viewlife Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

   //MARK: - Location Slider Action's
    @IBAction func actionSliderVwLocation(_ sender: UISlider) {
        sliderLableP.text = "\(Int(sender.value))km"
        sender.value = roundf(sender.value)
        let trackRect = sender.trackRect(forBounds: sender.frame)
        let thumbRect = sender.thumbRect(forBounds: sender.bounds, trackRect: trackRect, value: sender.value)
        self.sliderLableP.center = CGPoint(x: thumbRect.midX, y: self.sliderVwLocation.center.y + 40)
        callbackSliderVal?(Int(sender.value))
    }
    
    //MARK: - Configure Slider values
    func configureSliderValue(_ distanceVal: Int) {
        if !isOpen {
            isOpen = true
            self.sliderVwLocation.value = Float(distanceVal)
            self.sliderLableP = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
            self.sliderLableP.textAlignment = NSTextAlignment.center
            self.sliderLableP.textColor = UIColor.black
            self.sliderLableP.font = UIFont(name: AppStyle.Fonts.interMedium, size: 13)
            self.sliderLableP.text = "\(Int(self.sliderVwLocation.value))km"
            self.sliderVwLocation.value = roundf(self.sliderVwLocation.value)
            let trackRect = self.sliderVwLocation.trackRect(forBounds: self.sliderVwLocation.frame)
            let thumbRect = self.sliderVwLocation.thumbRect(forBounds: self.sliderVwLocation.bounds, trackRect: trackRect, value: self.sliderVwLocation.value)
            self.sliderLableP.center = CGPoint(x: thumbRect.midX, y: self.sliderVwLocation.center.y + 40)
            self.vwSlider.addSubview(self.sliderLableP)
        }
    }
    
}
