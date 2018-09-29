//
//  Graph.swift
//  ARDataStructures
//
//  Created by Akash Rastogi on 21/07/18.
//

import Foundation


//MARK: Vertex implementation
public struct Vertex<T: Hashable> {
    public let data:T
    public init(data: T) {
        self.data = data
    }
}

extension Vertex: Hashable {
    
    //For Hashable conformance you must provide a hashValue property.
    public var hashValue: Int {
        return data.hashValue
    }
    
    //Hashable inherits from the Equatable protocol. You must also add an equal-to operator for the custom type.
    static public func ==(lhs: Vertex, rhs: Vertex) -> Bool {
        return lhs.data == rhs.data
    }
}

extension Vertex: CustomStringConvertible {
    public var description: String {
        return "\(data)"
    }
}


//MARK: Edge implementation
//Whether an edge between two vertices is a directed path, or undirected path
public enum EdgeType {
    case directed
    case undirected
}

public struct Edge<T: Hashable> {
    public let source: Vertex<T>
    public let destination: Vertex<T>
    public let weight: Double?
    
    init(source: Vertex<T>, destination: Vertex<T>, weight:Double?) {
        self.source = source
        self.destination = destination
        self.weight = weight
    }
    
}

extension Edge: Hashable {
    public var hashValue: Int {
        return "\(source)\(destination)\(String(describing: weight))".hashValue
    }
    
    public static func == (lhs: Edge, rhs: Edge) -> Bool {
        return lhs.source == rhs.source &&
            lhs.destination == rhs.destination &&
            lhs.weight == rhs.weight
    }
}

extension Edge: CustomStringConvertible {
    public var description: String {
        return "source " + source.description +
            "\ndestination " + destination.description +
            "\nweight " + "\(String(describing:weight))"
    }
}

public class Graph<T: Hashable> {
    
    public var adjacencyDict: [Vertex<T>: [Edge<T>]] = [:]
    public init() {}
    
    public func addVertex(data: T) -> Vertex<T> {
        let vertex = Vertex<T>(data: data)
        if adjacencyDict[vertex] == nil {
            adjacencyDict[vertex] = []
        }
        return vertex
    }
    
    public func addEdge(type: EdgeType, from source: T, to destination: T, weight: Double?=nil) {
        let sourceVetrex = Vertex<T>(data: source)
        if adjacencyDict[sourceVetrex] == nil {
            adjacencyDict[sourceVetrex] = []
        }
        
        let destinationVetrex = Vertex<T>(data: destination)
        if adjacencyDict[destinationVetrex] == nil {
            adjacencyDict[destinationVetrex] = []
        }
        
        switch type {
        case .directed:
            addDirectedEdge(from: sourceVetrex, to: destinationVetrex, weight: weight)
        case .undirected:
            addUndirectedEdge(vertices: (sourceVetrex, destinationVetrex), weight: weight)
        }
    }
    
    public func weight(from source: T, to destination: T) -> Double? {
        let sourceVetrex = Vertex<T>(data: source)
        let destinationVetrex = Vertex<T>(data: destination)
        
        guard let arrEdges = adjacencyDict[sourceVetrex] else {
            return nil
        }
        for edge in arrEdges {
            if edge.destination == destinationVetrex {
                return edge.weight
            }
        }
        return nil
    }
    
    public func edges(from source: T) -> [Edge<T>]? {
        let vertex = Vertex<T>(data: source)
        return adjacencyDict[vertex]
    }
    
    //private methods
    private func addDirectedEdge(from source: Vertex<T>, to destination: Vertex<T>, weight: Double?) {
        let edge = Edge(source: source, destination: destination, weight: weight) // 1
        adjacencyDict[source]?.append(edge)
    }
    
    private func addUndirectedEdge(vertices: (Vertex<T>, Vertex<T>), weight: Double?) {
        let (source, destination) = vertices
        addDirectedEdge(from: source, to: destination, weight: weight)
        addDirectedEdge(from: destination, to: source, weight: weight)
    }
}

extension Graph where T:CustomStringConvertible {
    public var description: CustomStringConvertible {
        var result = ""
        for (vertex, edges) in adjacencyDict {
            var edgeString = ""
            for (index, edge) in edges.enumerated() {
                if index != edges.count - 1 {
                    edgeString.append("\(edge.destination), ")
                } else {
                    edgeString.append("\(edge.destination)")
                }
            }
            result.append("\(vertex) ---> [ \(edgeString) ] \n ")
        }
        return result
    }
}

//MARK: BFS- Breadth First Search
enum Visit<T: Hashable> {
    case source
    case edge(Edge<T>)
}

extension Graph {
    public func breadthFirstSearch(from source: Vertex<T>, to destination: Vertex<T>) -> [Edge<T>]? {
        var queue = Queue<Vertex<T>>()
        queue.enqueue(source)
        var visits : [Vertex<T> : Visit<T>] = [source: .source] // 1
        
        while let visitedVertex = queue.dequeue() {
            if visitedVertex == destination {
                var vertex = destination // 1
                var route : [Edge<T>] = [] // 2
                
                while let visit = visits[vertex],
                    case .edge(let edge) = visit { // 3
                        
                        route = [edge] + route
                        vertex = edge.source // 4
                        
                }
                return route // 5
            }
            let neighbourEdges = edges(from: visitedVertex.data) ?? []
            for edge in neighbourEdges {
                if visits[edge.destination] == nil { // 2
                    queue.enqueue(edge.destination)
                    visits[edge.destination] = .edge(edge) // 3
                }
            }
        }
        return nil
    }
}

//MARK: DFS- Depth First Search
extension Graph {
    
    public func depthFirstSearch(from start: Vertex<T>, to end: Vertex<T>) -> Stack<Vertex<T>> {
        var visited = Set<Vertex<T>>()
        var stack = Stack<Vertex<T>>()
        
        stack.push(start)
        visited.insert(start)
        
        outer: while let vertex = stack.peek(), vertex != end {
            
            guard let neighbours = edges(from: vertex.data), neighbours.count > 0 else {
//                print("backtrack from \(vertex)")
                let _ = stack.pop()
                continue
            }
            
            for edge in neighbours {
                if !visited.contains(edge.destination) {
                    visited.insert(edge.destination)
                    stack.push(edge.destination)
                    continue outer
                }
            }
            
//            print("backtrack from \(vertex)")
            let _ = stack.pop()
            
        }
        return stack
    }
}


/*
 //MARK: Graphable Protocol declaration
 protocol Graphable {
 associatedtype Element: Hashable
 var description: CustomStringConvertible {get}
 
 func createVertex(data: Element) -> Vertex<Element>
 func addEdge(type: EdgeType, from source:Vertex<Element>, to destination:Vertex<Element>, weight:Double?)
 
 func weight(from source: Vertex<Element>, to destination: Vertex<Element>) -> Double?
 func edges(from source: Vertex<Element>) -> [Edge<Element>]?
 }
 
 //MARK: Adjacency List implementation
 open class AdjacencyList<T: Hashable> {
 public var adjacencyDict: [Vertex<T>: [Edge<T>]] = [:]
 public init() {}
 }
 
 extension AdjacencyList: Graphable {
 public typealias Element = T
 
 var description: CustomStringConvertible {
 var result = ""
 for (vertex, edges) in adjacencyDict {
 var edgeString = ""
 for (index, edge) in edges.enumerated() {
 if index != edges.count - 1 {
 edgeString.append("\(edge.destination), ")
 } else {
 edgeString.append("\(edge.destination)")
 }
 }
 result.append("\(vertex) ---> [ \(edgeString) ] \n ")
 }
 return result
 }
 
 func createVertex(data: T) -> Vertex<T> {
 let vertex = Vertex<T>(data: data)
 if adjacencyDict[vertex] == nil {
 adjacencyDict[vertex] = []
 }
 return vertex
 }
 
 public func addEdge(type: EdgeType, from source: Vertex<T>, to destination: Vertex<T>, weight: Double?) {
 switch type {
 case .directed:
 addDirectedEdge(from: source, to: destination, weight: weight)
 case .undirected:
 addUndirectedEdge(vertices: (source, destination), weight: weight)
 }
 }
 
 func weight(from source: Vertex<T>, to destination: Vertex<T>) -> Double? {
 guard let arrEdges = adjacencyDict[source] else {
 return nil
 }
 for edge in arrEdges {
 if edge.destination == destination {
 return edge.weight
 }
 }
 return nil
 }
 
 func edges(from source: Vertex<T>) -> [Edge<T>]? {
 return adjacencyDict[source]
 }
 
 
 fileprivate func addDirectedEdge(from source: Vertex<T>, to destination: Vertex<T>, weight: Double?) {
 let edge = Edge(source: source, destination: destination, weight: weight) // 1
 adjacencyDict[source]?.append(edge)
 }
 
 fileprivate func addUndirectedEdge(vertices: (Vertex<T>, Vertex<T>), weight: Double?) {
 let (source, destination) = vertices
 addDirectedEdge(from: source, to: destination, weight: weight)
 addDirectedEdge(from: destination, to: source, weight: weight)
 }
 
 }
 */
