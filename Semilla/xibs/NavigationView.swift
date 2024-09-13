//
//  NavigationView.swift
//  UzCarConnect
//
//  Created by netset on 03/11/22.
//

import UIKit

protocol NavigationActions: AnyObject {
    func backButtonClicked()
    func editProfileClicked()
}
extension NavigationActions {
    func editProfileClicked() {}
}

class NavigationView: UIView {
    
    //MARK: IBOutlet's
    @IBOutlet private weak var btnBack: UIButton!
    @IBOutlet private weak var btnEditProfile: UIButton!
    @IBOutlet private weak var lblTitle: UILabel!
    
    //MARK: Variables Declaration
    let nibName = "NavigationView"
    var contentView: UIView?
    weak var delegate: NavigationActions?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
    }
    
    //MARK: IBAction's
    @IBAction func btnBack(_ sender: UIButton) {
        sender.tag == 1 ? delegate?.editProfileClicked(): delegate?.backButtonClicked()
    }
    
    //MARK: Custom Function
    func setData(title: String, hideBackBtn: Bool = false, hideEditBtn: Bool = true) {
        lblTitle.text = title
        (btnBack.isHidden, btnEditProfile.isHidden) = (hideBackBtn, hideEditBtn)
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
