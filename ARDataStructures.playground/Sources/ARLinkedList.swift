//
//  ARLinkedList.swift
//  ARDataStructures
//
//  Created by Akash Rastogi on 16/07/18.
//

import Foundation

public class Node<T> {
    var value:T
    var next: Node<T>?
    weak var previous: Node<T>?
    
    public init(value:T) {
        self.value = value
    }
}

extension Node: CustomStringConvertible {
    public var description: String {
        return "Node value- " + "\(value)"
    }
}


public class ARLinkedList<T>{
    
    fileprivate var head: Node<T>?
    fileprivate var tail: Node<T>?
    
    public init() {
        
    }
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var first: Node<T>?{
        return head
    }
    
    public var last: Node<T>?{
        return tail
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
        }
        else if next == nil { //removing last node
            tail = prev
        }
        else { //removing node from middle
            prev?.next = next
            next?.previous = prev
        }
        
        /*
         if let prev = prev { //since previous node exists, not a first node
         prev.next = next
         }
         else { //removing first node
         head = next
         }
         next?.previous = prev
         
         if next == nil { //removing last node
         tail = prev
         }
         */
        
        //Assign nil to the removed nodes previous and next pointers sothat can be removed from memory
        node.previous = nil
        node.next = nil
        
        return node.value
    }
}

extension ARLinkedList: CustomStringConvertible {
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
