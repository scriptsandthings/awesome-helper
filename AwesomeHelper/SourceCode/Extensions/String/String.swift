//
//  String.swift
//  AwesomeHelper
//
//  Created by Serhii Londar on 1/30/18.
//  Copyright © 2018 slon. All rights reserved.
//

import Foundation

extension String {
    func fromBase64(options: Data.Base64DecodingOptions) -> String? {
        guard let data = Data(base64Encoded: self, options: options) else {
            return nil
        }
        
        return String(data: data as Data, encoding: String.Encoding.utf8)
    }
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self, options: Data.Base64DecodingOptions.ignoreUnknownCharacters) else {
            return nil
        }
        
        return String(data: data as Data, encoding: String.Encoding.utf8)
    }
    
    func toBase64() -> String? {
        guard let data = self.data(using: String.Encoding.utf8) else {
            return nil
        }
        
        return data.base64EncodedString()
    }
    
    func toBase64(options: Data.Base64EncodingOptions) -> String? {
        guard let data = self.data(using: String.Encoding.utf8) else {
            return nil
        }
        
        return data.base64EncodedString(options: options)
    }
}
