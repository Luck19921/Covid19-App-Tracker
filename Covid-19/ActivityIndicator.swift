//
//  ActivityIndicator.swift
//  Covid-19
//
//  Created by Albert Cheng on 2020/8/31.
//  Copyright © 2020 Albert Cheng. All rights reserved.
//

import Foundation
import SwiftUI

struct Indicator: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<Indicator>) -> UIActivityIndicatorView {
        let v = UIActivityIndicatorView(style: .large)
        v.startAnimating()
        return v
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<Indicator>) {
    }
}
