//
//  SinglyLinkedList
//  ARDataStructures
//
//  Created by Akash Rastogi on 30/09/18.
//

import Foundation

///Typealiasing the node class to increase readability of code
public typealias SinglyLinkedListNode<T: Equatable> = SinglyLinkedList<T>.SNode<T>

public final class SinglyLinkedList<T: Equatable>{
    
    /// Linked List's Node Class Declaration
    public class SNode<T> {
        var value:T
        var next: SNode<T>?
        
        public init(value:T) {
            self.value = value
        }
    }
    
    fileprivate var head: SinglyLinkedListNode<T>?
    
    public init() { }
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var first: SinglyLinkedListNode<T>?{
        return head
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
        let newNode = SinglyLinkedListNode(value: value)
        
        if var temp = head {
            while let next = temp.next {
                temp = next
            }
            temp.next = newNode
        }
        else {
            head = newNode
        }
    }
    
    public func insert(_ value: T, at index: Int) {
        //Create a new node
        let newNode = SinglyLinkedListNode(value: value)
        if index == 0 {
            newNode.next = head
            head = newNode
        }
        else if index <= count {
            let prev = nodeAt(index: index - 1)
            let current = nodeAt(index: index)
            prev?.next = newNode
            newNode.next = current
            print(self)
        }
    }
    
    public func nodeAt(index: Int) -> SinglyLinkedListNode<T>?{
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
    }
    
    public func remove(node: SinglyLinkedListNode<T>){
        let next = node.next
        
        if head === node { //removing head node
            head = next
        }
        else {
            var temp = head
            var prev: SinglyLinkedListNode<T>?
            while temp != nil, temp !== node {
                prev = temp
                temp = temp?.next
            }
            
            // If key was not present in linked list
            if temp == nil {
                return
            }
            
            // Unlink the node from linked list
            prev?.next = temp?.next
        }
    }
}

extension SinglyLinkedList: CustomStringConvertible {
    public var description: String {
        
        let topDivider = "---Singly Linked List---\n"
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

extension SinglyLinkedListNode: CustomStringConvertible {
    public var description: String {
        return "Node value- " + "\(value)"
    }
}

