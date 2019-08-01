//
//  HashTable.swift
//  ARDataStructures
//
//  Created by Akash Rastogi on 31/07/19.
//

import Foundation

public struct HashTable<Key: Hashable, Value> {
    private typealias Element = (key: Key, value: Value)
    private typealias Bucket = [Element]
    
    private var buckets: [Bucket]
    
    private(set) public var count = 0
    
    public var isEmpty: Bool {
        return  count == 0
    }
    
    public init(capacity: Int) {
        assert(capacity>0, "capacity should be greater than 0")
        buckets = Array(repeating: [], count: capacity)
    }
    
    public subscript(key: Key) -> Value? {
        get {
            return self.value(forKey: key)
        }
        set {
            if let _val = newValue {
                self.updateValue(_val, forKey: key)
            }
            else {
                self.removeValue(forKey: key)
            }
        }
    }
    
    @discardableResult public mutating func updateValue(_ value: Value, forKey key: Key) -> Value? {
        let index = self.index(for: key)
        
        // Do we already have this key in the bucket?
        for (i, element) in buckets[index].enumerated() {
            if element.key == key {
                let oldValue = element.value
                buckets[index][i].value = value
                return oldValue
            }
        }
        
        // This key isn't in the bucket yet; add it to the chain.
        buckets[index].append((key: key, value: value))
        count += 1
        return nil
    }
    
    @discardableResult public mutating func removeValue(forKey key: Key) -> Value? {
        let index = self.index(for: key)
        
        for (i, element) in buckets[index].enumerated() {
            if element.key == key {
                let oldValue = element.value
                buckets[index].remove(at: i)
                count -= 1
                return oldValue
            }
        }
        return nil
    }
    
    public func value(forKey key: Key) -> Value? {
        let index = self.index(for: key)
        for element in buckets[index] {
            if element.key == key {
                return element.value
            }
        }
        return nil  // key not in hash table
    }
    
    public mutating func removeAll() {
        buckets = Array.init(repeating: [], count: buckets.count)
        count = 0
    }
    
    private func index(for key: Key) -> Int {
        return abs(key.hashValue % buckets.count)
    }
}
