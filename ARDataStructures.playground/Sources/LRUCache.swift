//
//  LRUCache.swift
//  ARDataStructures
//
//  Created by Akash Rastogi on 29/09/18.
//

import Foundation

public class LRUCache<KeyType: Hashable> {
    private let maxSize: Int
    private var dictCache:[KeyType: Any] = [:]
    private var priorityList: DoublyLinkedList<KeyType> = DoublyLinkedList<KeyType>()
    private var dictKey2Node: [KeyType: DoublyLinkedListNode<KeyType>] = [:]
    
    public init?(_ maxSize: Int) {
        if maxSize <= 0 { return nil }
        self.maxSize = maxSize
    }
    
    public func get(_ key: KeyType) -> Any? {
        guard let val = dictCache[key] else {
            return nil
        }
        
        remove(key)
        insert(key, val: val)
        
        return val
    }
    
    public func set(_ key: KeyType, val: Any) {
        if dictCache[key] != nil {
            remove(key)
        } else if priorityList.count >= maxSize, let keyToRemove = priorityList.last?.value {
            remove(keyToRemove)
        }
        
        insert(key, val: val)
    }
    
    private func remove(_ key: KeyType) {
        dictCache.removeValue(forKey: key)
        guard let node = dictKey2Node[key] else {
            return
        }
        let _ = priorityList.remove(node: node)
        dictKey2Node.removeValue(forKey: key)
    }
    
    private func insert(_ key: KeyType, val: Any) {
        dictCache[key] = val
        priorityList.insert(key, at: 0)
        guard let first = priorityList.first else {
            return
        }
        dictKey2Node[key] = first
    }
}
