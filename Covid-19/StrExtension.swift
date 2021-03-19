//
//  StrExtension.swift
//  Covid-19
//
//  Created by Albert Cheng on 2020/8/31.
//  Copyright © 2020 Albert Cheng. All rights reserved.
//

import Foundation

//String的Extension, 是為了將URL(string: xxx)中的 URL string進行重新編碼(例如像是空白鍵 S. Korea)
extension String {
    //將原始URL String -> 編碼成為Valid的URL String
    func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
    
    //將原始或被編輯過的URL String -> 解碼轉換為最原始的URL String
    func urlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
    }
}
