//
//  Tree.swift
//  ARDataStructures
//
//  Created by Akash Rastogi on 17/07/18.
//

import Foundation

public class TreeNode<T> {
    public let value: T
    
    private(set) public weak var parent: TreeNode<T>?
    private(set) public var children = [TreeNode<T>]()
    
    public init(value: T) {
        self.value = value
    }
    
    public func addChild(childValue: T) {
        let node = TreeNode<T>(value: childValue)
        addChildNode(node:node)
    }
    
    public func addChildNode(node:TreeNode<T>) {
        node.parent = self
        self.children.append(node)
    }
}

extension TreeNode where T: Equatable {
    
    public func search(_ value: T) -> TreeNode? {
        
        if value == self.value {
            return self
        }
        for child in children {
            if let found = child.search(value) {
                return found
            }
        }
        return nil
    }
}

extension TreeNode: CustomStringConvertible {
    public var description: String {
        var s = "\(value)"
        if !children.isEmpty {
            s += " {" + children.map { $0.description }.joined(separator: ", ") + "}"
        }
        return s
    }
}
