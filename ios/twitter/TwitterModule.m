//
//  TwitterModule.m
//  twitter
//
//  Created by Garrett Richards on 2/15/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import <React/RCTBridgeModule.h>
#import <React/RCTLog.h>


@interface TwitterModule : NSObject <RCTBridgeModule>
@end

@implementation TwitterModule

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(foo:(NSString *)name)
{
  RCTLogInfo(@"%s foo : name: %@", __func__, name);
}

@end
