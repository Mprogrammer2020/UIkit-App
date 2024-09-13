//
//  CommonEnumFile.swift
//  AIattorney
//
//  Created by netset on 03/07/23.
//

import Foundation

enum Storyboards: String {
    case main = "Main"
    case home = "Home"
    case checkout = "Checkout"
}

enum ViewControllers {
    static let welcomeVC = "WelcomeVC"
    static let loginVC = "LoginVC"
    static let signupVC = "SignUpVC"
    static let otpVerificationVC = "OTPVerificationVC"
    static let tabbarVC = "TabbarVC"
    static let homeVc = "HomeVC"
    static let filterVC = "FilterVC"
    static let categoriesVC = "CategoriesVC"
    static let cultivatorVC = "CultivatorVC"
    static let shoppingCartVC = "ShoppingCartVC"
    static let myProfileVC = "MyProfileVC"
    static let aboutUsVC = "AboutUsVC"
    static let itemDetailedVC = "ItemDetailedVC"
    static let orderHistoryVC = "OrderHistoryVC"
    static let orderHistoryDetailedVC = "OrderHistoryDetailedVC"
    static let myAddressesVC = "MyAddressesVC"
    static let helpAndSupportVC = "HelpAndSupportVC"
    static let creditCardsVC = "CreditCardVC"
    static let notificationsVC = "NotificationsVC"
    static let editAddressVC = "EditAddressVC"
    static let customizeQtyVC = "CustomizeQuantityVC"
    static let cultivatorsDetailedVC = "CultivatorsDetailedVC"
    static let paymentMethodVC = "PaymentMethodVC"
    static let checkoutVC = "CheckoutVC"
    static let addCardVC = "AddCardVC"
    static let mapViewVC = "MapViewVC"
    static let addressPopupVC = "AddressPopupVC"
    static let selectAddressMapVC = "SelectAddressMapVC"
    static let seeAllRecentlyItemsVC = "SeeAllRecentlyItemsVC"
    static let seeAllCultivatorVC = "SeeAllCultivatorVC"
    static let forgotPasswordVC = "ForgotPasswordVC"
    static let registrationSuccessfulVC = "RegistrationSuccessfulVC"
    static let searchHistoryVC = "SearchHistoryVC"
    static let topSellingProductsVC = "TopSellingProductsVC"
    static let ourProductsVC = "OurProductsVC"
    static let changeProfilePictureVC = "ChangeProfilePictureVC"
    static let signOutVC = "SignOutVC"
    static let customCalendarVC = "CustomCalendarVC"
    static let messageSentVC = "MessageSentVC"
    static let customerReviewsVC = "CustomerReviewsVC"
    static let orderPlacedVC = "OrderPlacedVC"
    static let driverReviewVC = "DriverReviewVC"
    static let productReviewVC = "ProductReviewsVC"
    static let editProfileVC = "EditProfileVC"
    static let confirmationVC = "ConfirmationVC"
    static let orderSuccessfullyDeliveredVC = "OrderSuccessfullyDeliveredVC"
    static let changeLanguageVC = "ChangeLanguageVC"
    static let virtualCreditsVC = "VirtualCreditsVC"
}


enum TableCells {
    static let customerReviewsTVC = "CustomerReviewsTVC"
    static let orderHistoryListTVC = "OrderHistoryListTVC"
    static let shoppingCartTVC = "ShoopingCartTVC"
    static let orderHistoryDetailedTVC = "OrderHistoryDetailedTVC"
    static let orderHistoryStatusTVC = "OrderHistoryStatusTVC"
    static let checkoutOrderListTVC = "CheckoutOrderListTVC"
    static let cardListTVC = "CardsListTVC"
    static let paymentMethodCardListTVC = "PaymentMethodCardListTVC"
    static let filterSectionTVC = "FilterSectionTVC"
    static let filterRowTVC = "FilterRowTVC"
    static let myAddressesListTVC = "AddresseslistTVC"
    static let notificationListTVC = "NotificationListTVC"
    static let filterLocationTVC = "FilterLocationTVC"
    static let addressPopupTVC = "AddressPopupTVC"
    static let creditHistoryTVC = "CreditHistoryTVC"
}

enum CollectionCells {
    static let categeoryCVC = "CategeoryCVC"
    static let recentlyListedCVC = "RecentlyListedCVC"
    static let bestFarmersCVC = "BestFarmersCVC"
    static let selectQtyCVC = "SelectQtyCVC"
    static let itemDetailedCVC = "ItemDetailedCVC"
}

enum HeaderTitle {
    static let login = "Login"
    static let cultivator = "Cultivator"
    static let categories = "Categories"
    static let shoppingcart = "Shopping Cart"
    static let myProfile = "My Profile"
    static let aboutUS = "About US"
    static let filter = "Filter"
    static let myAddress = "My Address"
    static let myAddresses = "My Addresses"
    static let editAddress = "Edit Address"
    static let creditCards = "Credit Cards"
    static let notifications = "Notifications"
    static let searchHistory = "Search History"
}

enum Param {
    static let accept = "Accept"
    static let contentType = "Content-Type"
    static let deviceId = "device-id"
    static let deviceType = "deviceType"
    static let appVersion = "version" // "app-version"
    static let auth = "Authorization"
    static let appJson = "application/json"
    static let ios = "I"
    static let deviceToken = "device-token"
    static let role = "role"
    static let user = "USER"
    static let acceptLanguage = "Accept-Language"
}

enum TextAlign {
    static let center = "C"
    static let left = "L"
}

enum WebPageTypes {
    static let TermsConditions = "Terms & Conditions"
    static let privacyPolicy = "Privacy Policy"
    static let cancellationPolicy = "Cancellation Policy"
}

enum NotificationKeys {
    
    static let updateLication = "UpdateLication"
}

enum ScreenTypes {
    static let editAddress = "Edit Address"
    static let addNewAddress = "Add New Address"
    static let inProgress = "In Progress"
    static let orderReadyForPickup = "Ready for Pickup"
    static let order_Intiated = "ORDER_INITIATED"
    static let out_For_Delivery = "OUT_FOR_DELIVERY"
    static let order_Delievered = "ORDER_DELIVERED"
    static let delivered = "DELIVERED"
    static let order_Cancelled = "ORDER_CANCELLED"
    static let searching_Delivery_Partner = "SEARCHING_DELIVERY_PARTNER"
    static let pickup_Confirmation_Pending = "PICKUP_CONFIRMATION_PENDING"
    static let pickup_Confirm = "PICKUP_CONFIRM"
    static let atDeliveryLocation = "AT_DELIVERY_LOCATION"
    static let pickUpPartnerVerified = "PICKUP_PARTNER_VERIFIED"
    static let awaitingPayment = "AWAITING_PAYMENT"
    static let reviewed = "Reviewed"
    static let login = "Login"
    static let signUp = "SignUp"
    static let order_Rejected = "ORDER_REJECTED"
    static let myEditProfile = "MyEditProfile"
    static let OrderDetail = "OrderDetail"
    static let orderPlaced = "orderPlaced"
    static let orderAccept = "Accept"
    static let virtualCredits = "VIRTUAL_CREDITS"
    static let orderTimeOut = "ORDER_TIMED_OUT"
    
}

enum ScreenTypeMyAddress {
    static let isComingFromMyProfile = "My Profile"
    static let isComingFromShoppingCart = "Shopping Cart"
}

enum AppRoles {
    static let user = "user"
}

enum selectedType {
    static let home = "Home"
    static let office = "Office"
    static let other = "Other"
    
    static let amex = "AMEX"
    static let codensa = "CODENSA"
    static let diners = "DINERS"
    static let mastercard = "MASTERCARD"
    static let masterCardDebit = "MASTERCARD_DEBIT"
    static let visa = "VISA"
    static let visaDebit = "VISA_DEBIT"
}

enum notifiTitles {
    static let orderAccepted = "Order Accepted"
    static let orderPlaced = "Order Placed"
    static let outForDelivery = "Out For Delivery"
    static let orderDelivered = "Order Delivered"
    static let deliveryPartnerAssign = "Delivery Partner Assigned"
    static let orderCancelled = "Order Cancelled"
    static let orderRejected = "Order Rejected"
    static let atDeliveryLocation = "At Delivery Location"
    static let virtualCredits = "Virtual Credits"
}
