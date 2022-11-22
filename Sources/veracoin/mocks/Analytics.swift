//
//  Analytics.swift
//  Veracoin
//
//  This is support code for the Mock Mobile Development environment
//  You should not revise this code or it may break the lesson. 
//
//  Firebase like Analytics
//

import Foundation

extension Dictionary {
    var jsonStringRepresentaiton: String? {
        guard let theJSONData = try? JSONSerialization.data(withJSONObject: self, options: [.sortedKeys]) else {
            return nil
        }

        return String(data: theJSONData, encoding: .ascii)
    }
}

// Firebase Events
let AnalyticsEventAddPaymentInfo = "add_payment_info"
let AnalyticsEventAddToCart = "add_to_cart"
let AnalyticsEventAddToWishlist = "add_to_wishlist"
let AnalyticsEventAdImpression = "ad_impression"
let AnalyticsEventAppOpen = "app_open"
let AnalyticsEventBeginCheckout = "begin_checkout"
let AnalyticsEventCampaignDetails = "campaign_details"
let AnalyticsEventCheckoutProgress = "checkout_progress"
let AnalyticsEventEarnVirtualCurrency = "earn_virtual_currency"
let AnalyticsEventEcommercePurchase = "ecommerce_purchase"
let AnalyticsEventGenerateLead = "generate_lead"
let AnalyticsEventJoinGroup = "join_group"
let AnalyticsEventLevelEnd = "level_end"
let AnalyticsEventLevelStart = "level_start"
let AnalyticsEventLevelUp = "level_up"
let AnalyticsEventLogin = "login"
let AnalyticsEventPostScore = "post_score"
let AnalyticsEventPresentOffer = "present_offer"
let AnalyticsEventPurchaseRefund = "purchase_refund"
let AnalyticsEventRemoveFromCart = "remove_from_cart"
let AnalyticsEventScreenView = "screen_view"
let AnalyticsEventSearch = "search"
let AnalyticsEventSelectContent = "select_content"
let AnalyticsEventSetCheckoutOption = "set_checkout_option"
let AnalyticsEventShare = "share"
let AnalyticsEventSignUp = "sign_up"
let AnalyticsEventSpendVirtualCurrency = "spend_virtual_currency"
let AnalyticsEventTutorialBegin = "tutorial_begin"
let AnalyticsEventTutorialComplete = "tutorial_complete"
let AnalyticsEventUnlockAchievement = "unlock_achievement"
let AnalyticsEventViewItem = "view_item"
let AnalyticsEventViewItemList = "view_item_list"
let AnalyticsEventViewSearchResults = "view_search_results"
let AnalyticsEventAddShippingInfo = "add_shipping_info"
let AnalyticsEventPurchase = "purchase"
let AnalyticsEventRefund = "refund"
let AnalyticsEventSelectItem = "select_item"
let AnalyticsEventSelectPromotion = "select_promotion"
let AnalyticsEventViewCart = "view_cart"
let AnalyticsEventViewPromotion = "view_promotion"


// Firebase Event Parameters
let AnalyticsParameterAchievementID = "achievement_id"
let AnalyticsParameterAdFormat = "ad_format"
let AnalyticsParameterAdNetworkClickID = "aclid"
let AnalyticsParameterAdPlatform = "ad_platform"
let AnalyticsParameterAdSource = "ad_source"
let AnalyticsParameterAdUnitName = "ad_unit_name"
let AnalyticsParameterAffiliation = "affiliation"
let AnalyticsParameterCampaign = "campaign"
let AnalyticsParameterCharacter = "character"
let AnalyticsParameterCheckoutStep = "checkout_step"
let AnalyticsParameterCheckoutOption = "checkout_option"
let AnalyticsParameterContent = "content"
let AnalyticsParameterContentType = "content_type"
let AnalyticsParameterCoupon = "coupon"
let AnalyticsParameterCP1 = "cp1"
let AnalyticsParameterCreativeName = "creative_name"
let AnalyticsParameterCreativeSlot = "creative_slot"
let AnalyticsParameterCurrency = "currency"
let AnalyticsParameterDestination = "destination"
let AnalyticsParameterEndDate = "end_date"
let AnalyticsParameterFlightNumber = "flight_number"
let AnalyticsParameterGroupID = "group_id"
let AnalyticsParameterIndex = "index"
let AnalyticsParameterItemBrand = "item_brand"
let AnalyticsParameterItemCategory = "item_category"
let AnalyticsParameterItemID = "item_id"
let AnalyticsParameterItemLocationID = "item_location_id"
let AnalyticsParameterItemName = "item_name"
let AnalyticsParameterItemList = "item_list"
let AnalyticsParameterItemVariant = "item_variant"
let AnalyticsParameterLevel = "level"
let AnalyticsParameterLocation = "location"
let AnalyticsParameterMedium = "medium"
let AnalyticsParameterNumberOfNights = "number_of_nights"
let AnalyticsParameterNumberOfPassengers = "number_of_passengers"
let AnalyticsParameterNumberOfRooms = "number_of_rooms"
let AnalyticsParameterOrigin = "origin"
let AnalyticsParameterPrice = "price"
let AnalyticsParameterQuantity = "quantity"
let AnalyticsParameterScore = "score"
let AnalyticsParameterScreenClass = "screen_class"
let AnalyticsParameterScreenName = "screen_name"
let AnalyticsParameterSearchTerm = "search_term"
let AnalyticsParameterShipping = "shipping"
let AnalyticsParameterSignUpMethod = "sign_up_method"
let AnalyticsParameterMethod = "method"
let AnalyticsParameterSource = "source"
let AnalyticsParameterStartDate = "start_date"
let AnalyticsParameterTax = "tax"
let AnalyticsParameterTerm = "term"
let AnalyticsParameterTransactionID = "transaction_id"
let AnalyticsParameterTravelClass = "travel_class"
let AnalyticsParameterValue = "value"
let AnalyticsParameterVirtualCurrencyName = "virtual_currency_name"
let AnalyticsParameterLevelName = "level_name"
let AnalyticsParameterSuccess = "success"
let AnalyticsParameterExtendSession = "extend_session"
let AnalyticsParameterDiscount = "discount"
let AnalyticsParameterItemCategory2 = "item_category2"
let AnalyticsParameterItemCategory3 = "item_category3"
let AnalyticsParameterItemCategory4 = "item_category4"
let AnalyticsParameterItemCategory5 = "item_category5"
let AnalyticsParameterItemListID = "item_list_id"
let AnalyticsParameterItemListName = "item_list_name"
let AnalyticsParameterItems = "items"
let AnalyticsParameterLocationID = "location_id"
let AnalyticsParameterPaymentType = "payment_type"
let AnalyticsParameterPromotionID = "promotion_id"
let AnalyticsParameterPromotionName = "promotion_name"
let AnalyticsParameterShippingTier = "shipping_tier"


class Analytics {

    static func logEvent(_ name: String, parameters: Dictionary<String, Any>?) {
        let json = parameters?.jsonStringRepresentaiton ?? "{}"

        if let ws = gWebSocket {
            ws.send("A|F|\(name)|\(json)")
        }   

        //do {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let nowString = dateFormatter.string(from: Date())

            let str = "\(nowString) Firebase(Veracoin) \(name) \(json)\n"
            let url = URL(fileURLWithPath: "log.txt")
            //try str.append(to: url, atomically: true, encoding: String.Encoding.utf8)

            if let outputStream = OutputStream(url: url, append: true) {
                outputStream.open()
                let _ = outputStream.write(str)
                outputStream.close()            
            }
        //} catch {
        //}    
    }
}