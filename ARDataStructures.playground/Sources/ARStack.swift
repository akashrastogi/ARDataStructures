//
//  ARStack.swift
//  ARDataStructures
//
//  Created by Akash Rastogi on 16/07/18.
//

import Foundation

//MARK: Stack implementation in swift
struct ARStack<T> {
    fileprivate var array: [T] = []
    
    mutating func push(_ element: T){
        array.append(element)
    }
    
    mutating func pop() -> T?{
        return array.popLast()
    }
    
    func peek() -> T?{
        return array.last
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
