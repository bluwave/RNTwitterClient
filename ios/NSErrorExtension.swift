//
//  NSErrorExtension.swift
//  twitter
//
//  Created by Garrett Richards on 2/16/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

import Foundation

private struct ErrorConstants {
  static let domain = "com.MyRNTwitterClient"
}

extension NSError {
  static func error(message: String, code: Int = 0) -> NSError {
    return NSError(domain: ErrorConstants.domain, code: code, userInfo: [NSLocalizedDescriptionKey: message])
  }
}
