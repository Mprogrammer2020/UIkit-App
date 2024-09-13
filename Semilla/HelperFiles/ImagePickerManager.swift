import UIKit
import AVFoundation

class ImagePickerManager: NSObject {
    
    var picker = UIImagePickerController()
    var pickImageCallback:((_ getImage: UIImage?,_ videoUrl: URL?) -> ())?
    var optionMenu = UIAlertController(title: nil, message:nil, preferredStyle: .actionSheet)
    var navController = UIViewController()
    
    //MARK: Intialization
    init (controller:UIViewController,imgPicker: UIImagePickerController) {
        self.navController = controller
        self.picker = imgPicker
    }
    
    func pickImage(image:Bool,video:Bool, _ callback: @escaping ((_ image: UIImage?,_ url: URL?) -> ())) {
        let cameraAction = UIAlertAction(title: AlertButtonsTitle.camera, style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.checkCameraValidations(image: image, video: video)
        })
        let galleryAction = UIAlertAction(title: AlertButtonsTitle.gallery, style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.openGallary(image: image, video: video)
        })
        let cancelAction = UIAlertAction(title: AlertButtonsTitle.cancel, style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        pickImageCallback = callback
        optionMenu.addAction(cameraAction)
        optionMenu.addAction(galleryAction)
        optionMenu.addAction(cancelAction)
        DispatchQueue.main.async {
            self.navController.present(self.optionMenu, animated: true, completion: nil)
        }
    }
    
    func alertForCameraPermission() {
        let alert = UIAlertController(title: AlertButtonsTitle.important,message: AlertMessages.cameraPermissionNotAccess,preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: AlertButtonsTitle.cancel, style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: AlertButtonsTitle.allowCamera, style: .cancel, handler: { (alert) -> Void in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
        }))
        navController.present(alert, animated: true, completion: nil)
    }
    
    func checkCameraValidations(image:Bool,video:Bool) {
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch (authStatus) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    DispatchQueue.main.async {
                        self.openCamera(image: true, video: false)
                    }
                }
            }
        case .restricted:
            alertForCameraPermission()
        case .denied:
            alertForCameraPermission()
        case .authorized:
            DispatchQueue.main.async {
                self.openGallary(image: image, video: video)
            }
        @unknown default:
            print("Error")
        }
    }
    
    func openCamera(image:Bool,video:Bool) {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            picker.sourceType = UIImagePickerController.SourceType.camera
            if (image == true) && (video == true) {
                picker.mediaTypes = ["public.image", "public.movie"]
                picker.videoMaximumDuration = 25
            } else if (image == true) && (video == false) {
                picker.mediaTypes = ["public.image"]
            } else if (image == false) && (video == true) {
                picker.mediaTypes = ["public.movie"]
                picker.videoMaximumDuration = 25
            }
            picker.allowsEditing = false
            navController.present(picker, animated: true, completion: nil)
        } else {
            Alerts.shared.showAlert(title: AlertMessages.appName, message: AlertButtonsTitle.cameraNotSupported)
        }
    }
    
    // MARK:-  Open galary Method 
    func openGallary(image:Bool,video:Bool) {
        if (image == true) && (video == true) {
            picker.mediaTypes = ["public.image", "public.movie"]
            picker.videoMaximumDuration = 25
        } else if (image == true) && (video == false) {
            picker.mediaTypes = ["public.image"]
        } else if (image == false) && (video == true) {
            picker.mediaTypes = ["public.movie"]
            picker.videoMaximumDuration  = 25
        }
        picker.allowsEditing = false
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.navController.present(picker, animated: true, completion: nil)
    }
}

extension ImagePickerManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let infoVal = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        picker.dismiss(animated: true) {
            if let image = info[.originalImage] as? UIImage {
                let currentCon = UIWindow.key.rootViewController
                CropperVC.sharedInstance.delegateCrop = self
                CropperVC.sharedInstance.cropperViewController(controller: currentCon!, image: image)
            } else if (info[.mediaURL] as? URL) != nil {
                let pickedVideo = infoVal[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.mediaURL)] as? URL ?? infoVal[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.mediaURL)] as! URL
                self.pickImageCallback?(nil, pickedVideo)
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

// MARK: Cropper ImageView Delegate
extension ImagePickerManager:cropperImageVwDelegate {
    
    func isImageCropper(image: UIImage?) {
        if let image = image {
            self.pickImageCallback?(image, nil)
        }
    }
}

func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}

func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}
