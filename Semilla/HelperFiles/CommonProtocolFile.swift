//
//  CommonProtocolFile.swift
//  AIattorney
//
//  Created by netset on 13/07/23.
//

import Foundation
import UIKit

protocol DelegatesWelcome {
    func gotoNext()
}

protocol DelegatesLogin {
    func gotoLogin(_ request:LoginRequest)
    func gotoSignUp()
    func goToGuestUser()
    func goToChangeLang()
}

protocol DelegatesSignUp {
    func gotoHome(_ request:SignUpRequest)
    func gotoSignIn()
    func goToPrivacyPolicy()
    func goToTermsAndCondition()
}

protocol DelegatesOTP {
    func gotoHomeScreen(_ request:OtpRequest)
    func goToBack()
    func goToResentOtp(_ request:OtpRequest)
}

protocol DelegatesHome {
    func gotoShoppingCart()
    func gotoFilter()
    func gotoNotifications()
    func gotoAddressPopup()
    func gotoSeeAllRecentlyItems()
    func gotoSeeAllCultivatorsList()
    func gotoSearchHistory()
}

protocol DelegatesMyProfile {
    func gotoBack()
    func gotoAboutUs()
    func gotoOrderHistory()
    func gotoNotification()
    func editProfile()
    func gotoHelpAndSupport()
    func myAddress()
    func gotoCreditCards()
    func signOut()
    func gotoChangeProfilePicture()
    func goToChangeLanguage()
    func goToCredits()
    func goToDeleteAccount()
}

protocol DelegatesFilter {
    func gotoBack()
    func gotoReset()
    func gotoApplyFilter()
}

protocol DelegatesNotification {
    func gotoBack()
}

protocol DelegatesItemDetailed {
    func gotoBack()
    func goToCustomerReviews()
    func gotoCustomizePopup()
    func goToCart()
    func goToAddToCart()
    func goToIncrementItem()
    func goToDecrementItem()
}

protocol DelegatesEditAddress {
    func gotoBack()
    func addressSave(_ request:AddAddressRequest)
}

protocol DelegatesCustomizeQuantity {
    func gotoBack()
    func callApiAddItemToCart()
}

protocol DelegatesCategories {
    func gotoFilter()
    func goToNotifi()
    func goToShoppingCart()
    func handleSearchData(_ textStr: String)
}

protocol DelegatesAboutUs {
    func gotoBack()
}

protocol DelegatesOrderHistory {
    func gotoBack()
}

protocol DelegatesMyAddress {
    func gotoBack()
    func gotoAddNewAddress()
    func goToAddAddress()
}

protocol DelegatesShoppingCart {
    func gotoCheckOut()
    func goToAddAddress()
    func goToBack()
    func goToAddCard()
    func goToMyAddresses()
    func goToMyCards()
    func goToApplyCredit()
    func goToAvailableCredits()
}

protocol DelegatesPaymentMethod {
    func gotoAddCard()
    func gotoNext()
    func gotoBack()
}

protocol DelegatesCheckout {
    func gotoBackToHome()
    func gotoTrackOrder()
    func gotoBack()
    func goToDriverCall()
    func goToDriverReviews()
    func goToProductReviews()
    func orderCancel()
}

protocol DelegatesSelectAddress {
    func gotoBack()
    func locationSaved(_ address:AutoCompleteModel)
}

protocol DelegatesMapView {
    func gotoBack()
    func goToOrderDetails()
    func goToGoogleMaps()
    func callNumber()
}

protocol DelegatesCreditCards {
    func gotoBack()
    func gotoAddCard()
    func goToAddNewCard()
}

protocol DelegatesSeeAllRecentlyItem {
    func gotoBack()
    func goToFilterData()
    func handleSearchData(_ textStr: String)
}

protocol DelegatesSeeAllCutivator {
    func gotoBack()
}

protocol DelegatesCultivatorsDetailed {
    func gotoBack()
    func gotoAllTopSellingProducts()
    func gotoAllOurProducts()
}

protocol DelegatesHelpAndSupport {
    func gotoBack()
    func goToMessageSent(_ request: HelpAndSupoortRequest)
}

protocol DelegatesAddCard {
    func gotoBack()
    func gotoCalendar()
    func callApiAddCard(_ request: AddCardRequest)
}

protocol DelegtesForgotPassword {
    func gotoBack()
    func gotoOtp()
}

protocol DelegatesRegistrationSuccessful {
    func gotoBack()
}

protocol DelegatesSearchHistory {
    func gotoBack()
    func goToFilter()
    func handleSearchData(_ textStr: String)
}

protocol DelegatesOrderHistoryDetailed {
    func gotoBack()
}

protocol DelegatesTopSellingProducts {
    func gotoBack()
}

protocol DelegatesOurProducts {
    func gotoBack()
}

protocol DelegatesCultivator {
    func handleSearchData(_ textStr: String)
    func goToNotifications()
    func goToShoppingCart()
    func goToFilter()
}

protocol DelegatesChangeProfilePicture {
    func gotoBack()
    func gotoCamera()
    func gotoGallary()
}

protocol DelegatesSignOut {
    func gotoRootView()
    func dismissPopUpView()
}

protocol DelegatesCustomCalendar {
    func gotoBack(_ month:String,_ year:String)
    func cancel()
}

protocol DelegatesOrderPlaced {
    func goToBack()
}

protocol DelegatesCustomerReviews {
    func goToBack()
}

protocol DelegatesMessageSent {
    func goToBack()
}

protocol DelegateDriverReviews {
    func goToBack()
    func goToReviewSubmit(_ request: DriverReviewRequest)
}


protocol DelegateProductReviews {
    func goToCheckout()
    func goToProductReviewSubmit(_ request: ProductReviewRequest)
}

protocol DelegatesEditProfile {
    func goToBack()
    func gotoSubmit(_ request: EditProfileRequest)
    func goTocamera()
}

protocol DelegatesConfirmation {
    func goToBack()
    func goToOrderPlaced()
}

protocol DelegateSavedAddress {
    func showSavedAddress(_ request:MyAddressesList?)
}
var delegateSavedAddress:DelegateSavedAddress?


protocol DelegateSavedCard {
    func showSavedCard(_ request:CardListResource?)
}

var delegateSavedCard:DelegateSavedCard?

protocol DelegatePushNotification {
    func handlePushNotification(_ orderId: Int)
}

protocol DelegatesChangeLanguage {
    func goToSubmit(_ selectedLanguage:String)
    func goToBack()
}

protocol DelegatesVirtualCredits {
    func goToBack()
    func goToHome()
}

var delegatePushNotification:DelegatePushNotification?
