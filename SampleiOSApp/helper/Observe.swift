//
//  Observe.swift
//  SampleiOSApp
//
//  Created by Ku Ku on 2/5/22.
//

import Foundation

class Observe<T> {
    typealias Listener = (T) -> Void
    private var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }

    
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
