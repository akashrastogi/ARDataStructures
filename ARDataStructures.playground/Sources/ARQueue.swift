//
//  ARQueue.swift
//  ARDataStructures
//
//  Created by Akash Rastogi on 16/07/18.
//

import Foundation

//MARK: Queue implementation in swift
public struct ARQueue<T> {
    
    fileprivate var array = [T]()
    
    public mutating func enqueue(_ element: T){
        array.append(element)
    }
    
    public mutating func dequeue() -> T?{
        if array.isEmpty == false     {
            return array.removeFirst()
        }
        else {
            return nil
        }
    }
    
    public func peek() -> T?{
        return array.first
    }
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public init() {
        
    }
}

//MARK: Description method
extension ARQueue: CustomStringConvertible {
    
    public var description: String {
        
        let topDivider = "---Queue---\n"
        let bottomDivider = "\n-----------\n"
        
        var strElement = ""
        for element in array{
            strElement.append("\n")
            strElement.append("\(element)")
            strElement.append("\n")
        }
                
        return topDivider + strElement + bottomDivider
    }
}
