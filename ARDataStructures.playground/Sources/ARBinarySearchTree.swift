//
//  ARBinarySearchTree.swift
//  ARDataStructures
//
//  Created by Akash Rastogi on 18/07/18.
//

import Foundation

public class ARBinarySearchTree<T: Comparable> {
    private(set) public var value: T
    private(set) public var parent: ARBinarySearchTree?
    private(set) public var left: ARBinarySearchTree?
    private(set) public var right: ARBinarySearchTree?
    
    public var isRoot: Bool {
        return parent == nil
    }
    
    public var isLeaf: Bool {
        return left == nil && right == nil
    }
    
    public var isLeftChild: Bool {
        return parent?.left === self
    }
    
    public var isRightChild: Bool {
        return parent?.right === self
    }
    
    public var hasLeftChild: Bool {
        return left != nil
    }
    
    public var hasRightChild: Bool {
        return right != nil
    }
    
    public var haAnyChild: Bool {
        return hasLeftChild || hasRightChild
    }
    
    public var hasBothChildren: Bool {
        return hasLeftChild && hasRightChild
    }
    
    public var count: Int {
        return (left?.count ?? 0) + 1 + (right?.count ?? 0)
    }
    
    init(value:T) {
        self.value = value
    }
    
    public convenience init(array:[T]){
        precondition(array.count > 0)
        self.init(value: array.first!)
        for value in array.dropFirst() {
            insert(value: value)
        }
    }
    
    //Insert new value
    public func insert(value: T){
        if value < self.value { //move to left side
            
            if let left = left { //left exist, so insert into left node
                left.insert(value: value)
            }
            else { //left doesn't exist, create a new one
                left = ARBinarySearchTree(value: value)
                left?.parent = self
            }
            
        }
        else { //move to right side
            
            if let right = right { //right exist, so insert into right node
                right.insert(value: value)
            }
            else { //right doesn't exist, create a new one
                right = ARBinarySearchTree(value: value)
                right?.parent = self
            }
            
        }
    }
    
    //Search specific node
    public func search(value: T) -> ARBinarySearchTree? {
        if value < self.value {
            return left?.search(value: value)
        }
        else if value > self.value {
            return right?.search(value: value)
        }
        else {
            return self //found the value
        }
    }
    
    //Deletion of node
    public func remove(value:T) -> ARBinarySearchTree? {
        
        if let searchNode = self.search(value: value) {
            
            if searchNode.isLeaf { //node doesn't have any child
                if searchNode.parent?.left === searchNode {
                    searchNode.parent?.left = nil
                }
                else if searchNode.parent?.right === searchNode {
                    searchNode.parent?.right = nil
                }
            }
            else if searchNode.hasBothChildren == false { //node have one child either left or right
                let child = searchNode.left ?? searchNode.right
                if searchNode.parent?.left === searchNode {
                    searchNode.parent?.left = child
                }
                else if searchNode.parent?.right === searchNode {
                    self.parent?.right = child
                }
            }
            else if searchNode.hasBothChildren { //node have both children
                //Find maximum in the Left sub tree (or you can find minimum in the right sub tree)
                if let maximum = searchNode.left?.maximum() {
                    searchNode.value = maximum.value //copy the minimum value to the node to be deleted
                    
                    //Disconect the "maximum" node
                    if maximum.parent?.left === maximum {
                        maximum.parent?.left = nil
                    }
                    else if maximum.parent?.right === maximum {
                        maximum.parent?.right = nil
                    }
                }
            }
            
            return searchNode
        }
        return nil
    }
    
    //Depth: Calculates the depth of this node, i.e. the distance to the root. Takes O(h) time.
    public func depth() -> Int {
        var node = self
        var edges = 0
        while let parent = node.parent {
            node = parent
            edges += 1
        }
        return edges
    }
    
    //Height: Calculates the height of this node, i.e. the distance to the lowest leaf. Since this looks at all children of this node, performance is O(n).
    public func height() -> Int {
        if isLeaf {
            return 0
        }
        else {
            return 1 + max(left?.height() ?? 0, right?.height() ?? 0)
        }
    }
    
    //Predecessor: Finds the node whose value precedes our value in sorted order.
    public func predecessor() -> ARBinarySearchTree<T>? {
        if let left = left {
            return left.maximum()
        }
        else {
            var node = self
            while let parent = node.parent {
                if parent.value < value {
                    return parent
                }
                node = parent
            }
            return nil
        }
    }
    
    //Successor: Finds the node whose value succeeds our value in sorted order.
    public func successor() -> ARBinarySearchTree<T>? {
        if let right = right {
            return right.minimum()
        }
        else {
            var node = self
            while let parent = node.parent {
                if parent.value > value {
                    return parent
                }
                node = parent
            }
            return nil
        }
    }
    
    //TODO: Is the search tree valid?
    
    //TODO: Traversal
    
    public func minimum() -> ARBinarySearchTree {
        var node = self
        while let left = node.left {
            node = left
        }
        return node
    }
    
    public func maximum() -> ARBinarySearchTree {
        var node = self
        while let right = node.right {
            node = right
        }
        return node
    }
    
}

extension ARBinarySearchTree: CustomStringConvertible {
    public var description: String {
        var s = ""
        if let left = left {
            s += "(\(left.description)) <- "
        }
        s += "\(value)"
        if let right = right {
            s += " -> (\(right.description))"
        }
        return s
    }
    
}
