//
//  ObservableProperty.swift
//  ReactiveReSwift
//
//  Created by Charlotte Tortorella on 29/11/16.
//  Copyright © 2016 Benjamin Encz. All rights reserved.
//
/*
 The MIT License (MIT)
 Copyright (c) 2016 ReSwift Contributors
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

/**
 This class is the default implementation of the `ObservablePropertyType` protocol. It is recommended
 that you do not use this observable and instead use an observable from a full FRP library.
 The existence of this class is to make ReactiveReSwift fully functional without third party libararies.
 */
public class ObservableProperty<ValueType>: ObservablePropertyType {
    public typealias DisposableType = ObservablePropertySubscriptionReferenceType
    public typealias ObservablePropertySubscriptionReferenceType = ObservablePropertySubscriptionReference<ValueType>
    internal var subscriptions = [ObservablePropertySubscriptionReferenceType : (ValueType) -> ()]()
    private var subscriptionToken: Int = 0
    private var retainReference: ObservableProperty<ValueType>?
    fileprivate var disposeBag = SubscriptionReferenceBag()
    private var queue: DispatchQueue?
    public var value: ValueType {
        didSet {
            let closure = {
                self.subscriptions.forEach { $0.value(self.value) }
            }
            queue?.async(execute: closure) ?? closure()
        }
    }

    public init(_ value: ValueType) {
        self.value = value
    }

    @discardableResult
    public func subscribe(_ function: @escaping (ValueType) -> Void) -> DisposableType? {
        defer { subscriptionToken += 1 }
        retainReference = self
        function(value)
        let reference = ObservablePropertySubscriptionReferenceType(key: String(subscriptionToken), stream: self)
        subscriptions.updateValue(function, forKey: reference)
        return reference
    }

    public func map<U>(_ transform: @escaping (ValueType) -> U) -> ObservableProperty<U> {
        let property = ObservableProperty<U>(transform(value))
        property.disposeBag += subscribe { value in
            property.value = transform(value)
        }
        return property
    }

    public func distinct(_ equal: @escaping (ValueType, ValueType) -> Bool) -> ObservableProperty<ValueType> {
        let property = ObservableProperty(value)
        property.disposeBag += subscribe { value in
            if !equal(value, property.value) {
                property.value = value
            }
        }
        return property
    }

    public func deliveredOn(_ queue: DispatchQueue) -> ObservableProperty<ValueType> {
        let property = map({ $0 })
        property.queue = queue
        return property
    }

    internal func unsubscribe(reference: ObservablePropertySubscriptionReferenceType) {
        subscriptions.removeValue(forKey: reference)
        if subscriptions.isEmpty {
            retainReference = nil
        }
    }
}

extension ObservableProperty where ValueType: Equatable {
    public func distinct() -> ObservableProperty<ValueType> {
        return distinct(==)
    }
}
