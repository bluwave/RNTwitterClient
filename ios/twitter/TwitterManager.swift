//
//  TwitterManager.swift
//  twitter
//
//  Created by Garrett Richards on 2/15/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

import Foundation
import SwifteriOS
import Social
import Accounts

@objc(TwitterManager)
class TwitterManager: NSObject {

    @objc(foo: callback:)
    func foo(name: String, callback: RCTResponseSenderBlock) -> Void {
        let res = "name: \(name)"
        callback([res])
    }

    @objc(feed: resolver: rejecter:)
    func feed(count: Int, resolver: @escaping RCTPromiseResolveBlock, rejecter: @escaping RCTPromiseRejectBlock) {
        let store = ACAccountStore()

        let errorHandler = { (rnRejectIdentifier: String, rnMessage: String, message: String) in
            let error = NSError.error(message: message)
            rejecter(rnRejectIdentifier, rnMessage, error)
        }

        if let accountType = store.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter) {
            store.requestAccessToAccounts(with: accountType, options: nil) { [weak self] (success, error) in
                if let error = error {
                    errorHandler("error_twitter_acces_forbidden", "Twitter access forbidden", error.localizedDescription)
                } else if success, let accounts = store.accounts(with: accountType), let account = accounts.first as? ACAccount {
                    let swifter = Swifter(account: account)
                    swifter.getHomeTimeline(count: count, success: { json in
                        if let convertedFormat = self?.convertResultingDataIntoConsumableFormat(jsonData: json) {
                            resolver(convertedFormat)
                        } else {
                            let errorMessage = "Unable to convert JSON objects to consumable js json"
                            errorHandler(errorMessage, errorMessage, errorMessage)
                        }
                    }, failure: { error in
                        errorHandler("twitter_feed_fetch_failure", "Twitter feed fetch failure", error.localizedDescription)
                    })
                } else {
                    //   FIXME: - it is possible to arrive to this points where the user gave access to accounts but has 0 accounts setup
                    errorHandler("twitter_client_internal_error", "Twitter client internal error", "Internal Error")
                }
            }
        } else {
            errorHandler("twitter_account_not_setup", "Twitter account not found", "Twitter account not setup, go to general > social > ...blah ...blah")
        }
    }

    typealias Tweet = [String: Any]

    //  this method is just a workaround the JSON lib used in SwiftieriOS twitter lib
    func convertResultingDataIntoConsumableFormat(jsonData: SwifteriOS.JSON) -> [Tweet]? {
        var result = [Tweet]()
        if let array = jsonData.array {
            for tweet in array {
                if let tweet = tweet.object {
                    var d = Tweet()
                    let keys = ["user.name", "user.screen_name", "text", "user.profile_image_url_https", "created_at"]
                    for k in keys {
                        let components = k.components(separatedBy: ".")
                        //  FIXME: - this only handles key path of user.___ , will not handle keypaths with depth bigger than 2, this is super hacky, dirty, should remove JSON parsing on SwiftieriOS side
                        if let first = components.first, let last = components.last, components.count > 1 {
                            d[last] = tweet[first]?.object?[last]?.description.replacingOccurrences(of:"\"", with:"", options:NSString.CompareOptions.literal, range:nil) ?? ""
                        } else {
                            d[k] = tweet[k]?.description ?? ""
                        }
                    }
                    result.append(d)
                }
            }
        }
        return result
    }
}
