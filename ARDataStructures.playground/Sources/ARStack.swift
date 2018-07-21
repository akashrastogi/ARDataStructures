//
//  ARStack.swift
//  ARDataStructures
//
//  Created by Akash Rastogi on 16/07/18.
//

import Foundation

//MARK: Stack implementation in swift
public struct ARStack<T> {
    fileprivate var array: [T] = []
    
    public mutating func push(_ element: T){
        array.append(element)
    }
    
    public mutating func pop() -> T?{
        return array.popLast()
    }
    
    public func peek() -> T?{
        return array.last
    }
    
    public init() {
        
    }
}


//MARK: Description method
extension ARStack: CustomStringConvertible {
    
    public var description: String {
        
        let topDivider = "---Stack---\n"
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
