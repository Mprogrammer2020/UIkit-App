//
//  CommonExtensions.swift
// BaseApp
//
//  Created by netset on 09/12/22.
//

import UIKit
import SDWebImage
import GoogleMaps

extension UIWindow {
    
    static var key: UIWindow! {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}

extension JSONDecoder {
    func decode<T : Decodable> (model: T.Type, data: Data) -> T? {
//        do {
            let myStruct = try! self.decode(model, from: data)
            return myStruct
//        } catch {
//            return nil
//        }
    }
}

extension UserDefaults {
    
    func setData<T: Encodable>(encodable: T, forKey key: String) {
        if let data = try? JSONEncoder().encode(encodable) {
            set(data, forKey: key)
        }
    }
    
    func valueData<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        if let data = object(forKey: key) as? Data,
           let value = try? JSONDecoder().decode(type, from: data) {
            return value
        }
        return nil
    }
}

extension UIImageView {
    
    func setImageOnImageViewWithoutServer(_ urlStr: String,placeholder: UIImage) {
        self.sd_setImage(with: URL(string: urlStr), placeholderImage: placeholder, options: .highPriority, completed: nil)
    }
    
    func setImageOnImageViewServer(_ urlStr: String,placeholder: UIImage) {
        self.sd_setImage(with: URL(string: "\(ServerLink.imageUploadBaseUrl)\(urlStr)"), placeholderImage: placeholder, options: .highPriority, completed: nil)
    }
}


extension UIDevice {
    
    var hasSafeArea: Bool {
        let bottom = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}
extension UIColor {
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
           var hexFormatted: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
           
           if hexFormatted.hasPrefix("#") {
               hexFormatted.remove(at: hexFormatted.startIndex)
           }
           
           assert(hexFormatted.count == 6, "Invalid hex code used.")
           
           var rgbValue: UInt64 = 0
           Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
           
           let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
           let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
           let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
           
           self.init(red: red, green: green, blue: blue, alpha: alpha)
       }
    
}

extension GMSMapView {
    
    func setCameraPosition(lat:Double,long:Double,zoom:Float) {
        let getCamera:GMSCameraPosition = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: zoom)
        self.camera = getCamera
    }
    
    func setCameraPosition(lat:String,long:String,zoom:Float) {
        let getCamera:GMSCameraPosition = GMSCameraPosition.camera(withLatitude: Double(lat) ?? 0, longitude: Double(long) ?? 0, zoom: zoom)
        self.camera = getCamera
    }
}

extension UIButton {
    func addToolTip(_ text: String, backgroundColor: UIColor, textColor: UIColor) {
        let toolTip = UILabel()
        toolTip.text = text
        toolTip.backgroundColor = backgroundColor
        toolTip.textColor = textColor
        toolTip.textAlignment = .center
        toolTip.layer.cornerRadius = 5
        toolTip.clipsToBounds = true
        self.addSubview(toolTip)
        toolTip.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toolTip.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            toolTip.bottomAnchor.constraint(equalTo: self.topAnchor, constant: -10)
        ])
        // Animate tooltip
        UIView.animate(withDuration: 0.3, delay: 2.0, options: .curveEaseOut, animations: {
            toolTip.alpha = 0.0
        }, completion: { _ in
            toolTip.removeFromSuperview()
        })
    }
}
