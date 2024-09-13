//
//  AppAlertConstant.swift
//  Semilla
//
//  Created by Netset on 29/04/24.
//

import Foundation

// MARK: Varibales
var AlertMessages = alertMessages()
var AlertButtonsTitle = alertButtonsTitle()
var ValidationMessages = validationMessages()
var DisplayNames = displayNames()


struct alertMessages {
    
    var appName: String { "appName".localizeString(selectedLang: preferredLang) }
    var okay: String { "okay".localizeString(selectedLang: preferredLang) }
    var checkInternet:String { "checkInternet".localizeString(selectedLang: preferredLang)}
    var noInternetConnection:String { "noInternetConnection".localizeString(selectedLang: preferredLang)}
    var pleaseReviewyournetworksettings:String { "pleaseReviewyournetworksettings".localizeString(selectedLang: preferredLang)}
    var serverNotResponding:String { "serverNotResponding".localizeString(selectedLang: preferredLang)}
    var cameraPermissionNotAccess:String { "cameraPermissionNotAccess".localizeString(selectedLang: preferredLang)}
    var settingPermission:String { "settingPermission".localizeString(selectedLang: preferredLang)}
    var sessionExpire:String { "sessionExpire".localizeString(selectedLang: preferredLang)}
    var logoutMsg:String { "logoutMsg".localizeString(selectedLang: preferredLang)}
    var serverNotRespondTryAgain:String { "serverNotRespondTryAgain".localizeString(selectedLang: preferredLang)}
    var errrOccured:String { "errrOccured".localizeString(selectedLang: preferredLang)}
    var incorrectCardDetails:String { "incorrectCardDetails".localizeString(selectedLang: preferredLang)}
    var performLoginrequired:String { "performLoginrequired".localizeString(selectedLang: preferredLang)}
    var cultivatorOutsideChangeAddress:String { "cultivatorOutsideChangeAddress".localizeString(selectedLang: preferredLang)}
    var outOfStock:String { "outOfStock".localizeString(selectedLang: preferredLang)}
    var itemHasOutOfStock:String { "itemHasOutOfStock".localizeString(selectedLang: preferredLang)}
    var maximumQuantitLimitReached:String { "maximumQuantitLimitReached".localizeString(selectedLang: preferredLang)}
    var addressUpdatedSuccessfully:String { "addressUpdatedSuccessfully".localizeString(selectedLang: preferredLang)}
    var addressAddedSuccessfully:String { "addressAddedSuccessfully".localizeString(selectedLang: preferredLang)}
    var areYouSureYouWantToCancelOrder:String { "areYouSureYouWantToCancelOrder".localizeString(selectedLang: preferredLang)}
    var numberIsNotValid:String { "numberIsNotValid".localizeString(selectedLang: preferredLang)}
    var noNumberShowing:String { "noNumberShowing".localizeString(selectedLang: preferredLang)}
    var areYouSureYouWantToDeleteAddress:String { "areYouSureYouWantToDeleteAddress".localizeString(selectedLang: preferredLang)}
    var areYouSureYouWantToDeleteCard:String { "areYouSureYouWantToDeleteCard".localizeString(selectedLang: preferredLang)}
    var noItemsFound :String { "noItemsFound".localizeString(selectedLang: preferredLang)}
    var byContinuingYouAgreeToOur:String { "byContinuingYouAgreeToOur".localizeString(selectedLang: preferredLang)}
    var and:String { "and".localizeString(selectedLang: preferredLang)}
    var enterTheOTPSentTo:String { "enterTheOTPSentTo".localizeString(selectedLang: preferredLang)}
    var toolTipMessage:String { "toolTipMessage".localizeString(selectedLang: preferredLang)}
    var orderDeliveredSuccessfully:String { "orderDeliveredSuccessfully".localizeString(selectedLang: preferredLang)}
    var orderCanceled:String { "orderCanceled".localizeString(selectedLang: preferredLang)}
    var orderRejected:String { "orderRejected".localizeString(selectedLang: preferredLang)}
    var orderHasBeenPlacedSuccessfully:String { "orderHasBeenPlacedSuccessfully".localizeString(selectedLang: preferredLang)}
    var all:String { "all".localizeString(selectedLang: preferredLang)}
    var selectExpiryDate:String { "selectExpiryDate".localizeString(selectedLang: preferredLang)}
    var appNeedsPermission:String { "appNeedsPermission".localizeString(selectedLang: preferredLang)}
}

struct alertButtonsTitle {
    
    var okay:String { "okay".localizeString(selectedLang: preferredLang)}
    var cancel:String { "cancel".localizeString(selectedLang: preferredLang)}
    var setting:String { "setting".localizeString(selectedLang: preferredLang)}
    var camera:String { "camera".localizeString(selectedLang: preferredLang)}
    var gallery:String { "gallery".localizeString(selectedLang: preferredLang)}
    var important:String { "important".localizeString(selectedLang: preferredLang)}
    var allowCamera:String { "allowCamera".localizeString(selectedLang: preferredLang)}
    var cameraNotSupported:String { "cameraNotSupported".localizeString(selectedLang: preferredLang)}
    var grantPermissions:String { "grantPermissions".localizeString(selectedLang: preferredLang)}
    var yes:String { "yes".localizeString(selectedLang: preferredLang)}
    var login:String { "login".localizeString(selectedLang: preferredLang)}
    var no:String { "no".localizeString(selectedLang: preferredLang)}
    var addCard:String { "addCard".localizeString(selectedLang: preferredLang)}
    var changeCard:String { "changeCard".localizeString(selectedLang: preferredLang)}
    var addAddress:String { "addAddress".localizeString(selectedLang: preferredLang)}
    var changeAddress:String { "changeAddress".localizeString(selectedLang: preferredLang)}
    var submit:String { "submit".localizeString(selectedLang: preferredLang)}
    var next:String { "next".localizeString(selectedLang: preferredLang)}
    var goToCart:String { "goToCart".localizeString(selectedLang: preferredLang)}
    var addToCart:String { "addToCart".localizeString(selectedLang: preferredLang)}
    var exp:String { "exp".localizeString(selectedLang: preferredLang)}
    var update : String{"update".localizeString(selectedLang: preferredLang)}
}

struct validationMessages {
    
    var connectionProblem:String { "connectionProblem".localizeString(selectedLang: preferredLang)}
    var enterFirstName:String { "enterFirstName".localizeString(selectedLang: preferredLang)}
    var enterLastName:String { "enterLastName".localizeString(selectedLang: preferredLang)}
    var enterMobileNo:String { "enterMobileNo".localizeString(selectedLang: preferredLang)}
    var enterPhoneNo:String { "enterPhoneNo".localizeString(selectedLang: preferredLang)}
    var inValidMobileNo:String { "inValidMobileNo".localizeString(selectedLang: preferredLang)}
    var inValidPhoneNo:String { "inValidPhoneNo".localizeString(selectedLang: preferredLang)}
    var numberAlreadyRegistered:String { "numberAlreadyRegistered".localizeString(selectedLang: preferredLang)}
    var enterPassword:String { "enterPassword".localizeString(selectedLang: preferredLang)}
    var enterOtp:String { "enterOtp".localizeString(selectedLang: preferredLang)}
    var invalidOTP:String { "invalidOTP".localizeString(selectedLang: preferredLang)}
    var selectCountry:String { "selectCountry".localizeString(selectedLang: preferredLang)}
    var enterAddress:String { "enterAddress".localizeString(selectedLang: preferredLang)}
    var enterApartments:String { "enterApartments".localizeString(selectedLang: preferredLang)}
    var enterCity:String { "enterCity".localizeString(selectedLang: preferredLang)}
    var enterStreet:String { "enterStreet".localizeString(selectedLang: preferredLang)}
    var enterEmail:String { "enterEmail".localizeString(selectedLang: preferredLang)}
    var inValidEmail:String { "inValidEmail".localizeString(selectedLang: preferredLang)}
    var enterFullName:String { "enterFullName".localizeString(selectedLang: preferredLang)}
    var enterMessage:String { "enterMessage".localizeString(selectedLang: preferredLang)}
    var oTPSentSuccessfully:String { "oTPSentSuccessfully".localizeString(selectedLang: preferredLang)}
    var oTPReSentSuccessfully:String { "oTPReSentSuccessfully".localizeString(selectedLang: preferredLang)}
    var enterCardNo:String { "enterCardNo".localizeString(selectedLang: preferredLang)}
    var enterCardNoInvalid:String { "enterCardNoInvalid".localizeString(selectedLang: preferredLang)}
    var enterCardCvvInvalid:String { "enterCardCvvInvalid".localizeString(selectedLang: preferredLang)}
    var enterCardUser:String { "enterCardUser".localizeString(selectedLang: preferredLang)}
    var enterCardCvv:String { "enterCardCvv".localizeString(selectedLang: preferredLang)}
    var enterCardExpire:String { "enterCardExpire".localizeString(selectedLang: preferredLang)}
    var enterCardAddedSuccess:String { "enterCardAddedSuccess".localizeString(selectedLang: preferredLang)}
    var profileCreated:String { "profileCreated".localizeString(selectedLang: preferredLang)}
    var profileUpdated:String { "profileUpdated".localizeString(selectedLang: preferredLang)}
    var selectRating:String { "selectRating".localizeString(selectedLang: preferredLang)}
    var productAdded:String { "productAddedSuccess".localizeString(selectedLang: preferredLang)}
    var itemOutOfStock:String { "itemOutOfStock".localizeString(selectedLang: preferredLang)}
    var categories:String { "categories".localizeString(selectedLang: preferredLang)}
    var ratings:String { "ratings".localizeString(selectedLang: preferredLang)}
    var location:String { "location".localizeString(selectedLang: preferredLang)}
    var enterYourMessage:String { "enterYourMessage".localizeString(selectedLang: preferredLang)}
    var orderPlaced:String { "orderPlaced".localizeString(selectedLang: preferredLang)}
    var orderPlacedNew:String { "orderPlacedNew".localizeString(selectedLang: preferredLang)}
    var orderIntiated:String { "orderIntiated".localizeString(selectedLang: preferredLang)}
    var outForDelivery:String { "outForDelivery".localizeString(selectedLang: preferredLang)}
    var orderDelivered:String { "orderDelivered".localizeString(selectedLang: preferredLang)}
    var orderCanceled:String { "orderCanceled".localizeString(selectedLang: preferredLang)}
    var orderRejected:String { "orderRejected".localizeString(selectedLang: preferredLang)}
    var readyToPickup:String { "readyToPickup".localizeString(selectedLang: preferredLang)}
    var placedOn:String { "placedOn".localizeString(selectedLang: preferredLang)}
    var order:String { "order".localizeString(selectedLang: preferredLang)}
    var orderMinimumAmount:String { "orderMinimumAmount".localizeString(selectedLang: preferredLang)}
    var cultivatorStatus:String { "cultivatorStatus".localizeString(selectedLang: preferredLang)}    
    var letUsKnowWhatYouThink:String { "letUsKnowWhatYouThink".localizeString(selectedLang: preferredLang)}
    var noReviews:String { "noReviews".localizeString(selectedLang: preferredLang)}
    var english:String { "english".localizeString(selectedLang: preferredLang)}
    var spanish:String { "spanish".localizeString(selectedLang: preferredLang)}
    var  deleteAccountValidation : String {"deleteAccountValidation".localizeString(selectedLang: preferredLang)}
    var monthAgo:String { "monthAgo".localizeString(selectedLang: preferredLang)}
    var dayAgo:String { "dayAgo".localizeString(selectedLang: preferredLang)}
    var hourAgo:String { "hourAgo".localizeString(selectedLang: preferredLang)}
    var yearAgo:String { "yearAgo".localizeString(selectedLang: preferredLang)}
    var minuteAgo:String { "minuteAgo".localizeString(selectedLang: preferredLang)}
    var weekAgo:String { "weekAgo".localizeString(selectedLang: preferredLang)}
    var justNow:String { "justNow".localizeString(selectedLang: preferredLang)}
    var selectCardType:String { "selectCardType".localizeString(selectedLang: preferredLang)}
    var atTheMoment:String { "atTheMoment".localizeString(selectedLang: preferredLang)}
    var availableCred:String { "availableCred".localizeString(selectedLang: preferredLang)}
    var weWillNotify:String { "weWillNotify".localizeString(selectedLang: preferredLang)}
    var creditedOn:String { "creditedOn".localizeString(selectedLang: preferredLang)}
    var spentOn:String { "spentOn".localizeString(selectedLang: preferredLang)}
    var expired:String { "expired".localizeString(selectedLang: preferredLang)}
    var expiredOn:String { "expiredOn".localizeString(selectedLang: preferredLang)}
    var OA : String{"OA".localizeString(selectedLang: preferredLang)}
    var OP : String{"OP".localizeString(selectedLang: preferredLang)}
    var OFD : String{"OFD".localizeString(selectedLang: preferredLang)}
    var OD : String{"OD".localizeString(selectedLang: preferredLang)}
    var DPA : String{"DPA".localizeString(selectedLang: preferredLang)}
    var OC : String{"OC".localizeString(selectedLang: preferredLang)}
    var OR : String{"OR".localizeString(selectedLang: preferredLang)}
    var ADL : String{"ADL".localizeString(selectedLang: preferredLang)}
    var virtualCredits : String{"virtualCredits".localizeString(selectedLang: preferredLang)}
    var orderHasBeenCancelled : String{"orderHasBeenCancelled".localizeString(selectedLang: preferredLang)}
    var orderHasBeenRejected : String{"orderHasBeenRejected".localizeString(selectedLang: preferredLang)}

    
}

struct displayNames {
    
    var editAddress:String { "editAddress".localizeString(selectedLang: preferredLang)}
    var addNewAddress:String { "addNewAddress".localizeString(selectedLang: preferredLang)}
    var plusAddNewAddress:String { "plusAddNewAddress".localizeString(selectedLang: preferredLang)}
    var privacyPolicy:String { "privacyPolicy".localizeString(selectedLang: preferredLang)}
    var termsOfService:String { "termsOfService".localizeString(selectedLang: preferredLang)}
    var aboutUs:String { "aboutUs".localizeString(selectedLang: preferredLang)}
    var productDetails:String { "productDetails".localizeString(selectedLang: preferredLang)}
}
