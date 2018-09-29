//
//  DoublyLinkedList.swift
//  ARDataStructures
//
//  Created by Akash Rastogi on 16/07/18.
//

import Foundation

/// Typealiasing the node class to increase readability of code
public typealias Node<T> = DoublyLinkedList<T>.LinkedListNode<T>

public final class DoublyLinkedList<T>{
    
    /// Linked List's Node Class Declaration
    public class LinkedListNode<T> {
        var value:T
        var next: LinkedListNode<T>?
        weak var previous: LinkedListNode<T>?
        
        public init(value:T) {
            self.value = value
        }
    }
    
    fileprivate var head: Node<T>?
    fileprivate var tail: Node<T>?
    
    public init() { }
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var first: Node<T>?{
        return head
    }
    
    public var last: Node<T>?{
        return tail
    }
    
    /// Computed property to iterate through the linked list and return the total number of nodes
    public var count: Int {
        guard var node = head else {
            return 0
        }
        
        var count = 1
        while let next = node.next {
            node = next
            count += 1
        }
        return count
    }
    
    public func append(value: T){
        //Create a new node
        let newNode = Node(value: value)
        if let tailNode = tail { //tail is not empty
            newNode.previous = tailNode //update previous node of newly created node
            tailNode.next = newNode //update next node of last tail
        }
        else {
            head = newNode //since there is no node, set new node as head
        }
        
        tail = newNode //update tail
    }
    
    public func insert(_ value: T, at index: Int) {
        //Create a new node
        let newNode = Node(value: value)
        if index == 0 {
            newNode.next = head
            head?.previous = newNode
            head = newNode
            
            if tail == nil {
                var lastNode = head
                while lastNode?.next != nil {
                    lastNode = lastNode?.next
                }
                tail = lastNode
            }
        }
        else if index <= count {
            let prev = nodeAt(index: index - 1)
            let isPreviousNodeTail = prev?.next == nil
            let next = prev?.next
            newNode.previous = prev
            newNode.next = next
            next?.previous = newNode
            prev?.next = newNode
            if isPreviousNodeTail {
                tail = newNode
            }
        }
    }
    
    public func nodeAt(index: Int) -> Node<T>?{
        if index >= 0 {
            var current = head
            var count = 0// index of node we are currently looking at
            while current != nil {
                if count == index {
                    return current
                }
                count = count + 1
                current = current?.next
            }
        }
        
        return nil
    }
    
    public func removeAll(){
        head = nil
        tail = nil
    }
    
    public func remove(node: Node<T>) -> T{
        
        let prev = node.previous
        let next = node.next
        
        if prev == nil { //removing first node
            head = next
            if head == nil { //Reset tail dangling pointer, if exist
                tail = nil
            }
        }
        else if next == nil { //removing last node
            prev?.next = nil
            tail = prev
        }
        else { //removing node from middle
            prev?.next = next
            next?.previous = prev
        }
        
        //Assign nil to the removed nodes previous and next pointers sothat can be removed from memory
        node.previous = nil
        node.next = nil
        
        return node.value
    }
}

extension DoublyLinkedList: CustomStringConvertible {
    public var description: String {
        
        let topDivider = "---Linked List---\n"
        let bottomDivider = "\n-----------\n"
        
        var strElement = "["
        var node = head
        while node != nil {
            strElement += "\(node!.value)"
            node = node?.next
            if node != nil {
                strElement += ", "
            }
        }
        strElement += "]"
        
        return topDivider + strElement + bottomDivider
    }
    
}

extension DoublyLinkedList.LinkedListNode: CustomStringConvertible {
    public var description: String {
        return "Node value- " + "\(value)"
    }
}
