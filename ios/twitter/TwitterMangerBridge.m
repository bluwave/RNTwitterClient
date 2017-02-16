//
//  TwitterMangarBridge.m
//  twitter
//
//  Created by Garrett Richards on 2/15/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

@import Foundation;
#import <React/RCTBridgeModule.h>
#import <React/RCTLog.h>

@interface TwitterManagerBridge : NSObject <RCTBridgeModule>
@end

@interface RCT_EXTERN_MODULE(TwitterManager, NSObject)

RCT_EXTERN_METHOD(foo:(NSString *)name callback:(RCTResponseSenderBlock) callback)
RCT_EXTERN_METHOD(feed:(NSInteger) count resolver:(RCTPromiseResolveBlock)resolver rejecter:(RCTPromiseRejectBlock) rejecter)

@end
