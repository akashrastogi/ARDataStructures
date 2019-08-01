//: Playground - noun: a place where people can play

import Foundation

//Stack example
//pile of dinner plates, moulded chairs are real world example of Stack
//Back/Forward stacks on browsers are examples of Stack
var techStack = Stack<String>()
techStack.push("iOS programming")
techStack.push("Android programming")
techStack.push("Python")
techStack.push("Data Science")
techStack.push("Objective-C")
print("Stack before pop-")
print(techStack.description)
techStack.pop()
print("Stack after pop-")
print(techStack.description)
print("Peek of stack- \(techStack.peek() ?? "")")


//Queue example
//A real-world example of queue can be a single-lane one-way road, where the vehicle enters first, exits first. More real-world examples can be seen as queues at the ticket windows and bus-stops
//CPU scheduling, Disk Scheduling, processes in OS are examples of Queue DS
var personQueue = Queue<String>()
print("Is person queue empty- \(personQueue.isEmpty)")
personQueue.enqueue("Akash")
personQueue.enqueue("John")
personQueue.enqueue("Simon")
personQueue.enqueue("Charles")
print("person queue before dequeue")
print(personQueue.description)
personQueue.dequeue()
print("person queue after dequeue")
print(personQueue.description)


//Linked List example
//Train is a classic example of Linked List
//Music player is example of Double linked list
let list = SinglyLinkedList<Int>()
list.append(value: 0)
list.append(value: 1)
list.append(value: 2)
list.append(value: 4)
list.append(value: 5)
list.append(value: 6)
list.insert(3, at: 3)
print(list)
print("Node at index-3 is \(String(describing: list.nodeAt(index: 3)))")

let playerList = DoublyLinkedList<String>()
print("Is player list empty- \(playerList.isEmpty)")
playerList.append(value: "Song 1")
playerList.append(value: "Song 2")
playerList.append(value: "Song 3")
playerList.append(value: "Song 4")
print(playerList.description)
if let secondNode = playerList.nodeAt(index: 2) {
    print("Second Node-> \(secondNode)")
    playerList.remove(node: secondNode)
    print("Linked list after removed node at index-2")
    print(playerList.description)
}
playerList.removeAll()
print("Remove all songs from player list")
print(playerList.description)


//Tree example
var tree = TreeNode<Int>(value: 10)
tree.addChild(childValue: 20)
tree.addChild(childValue: 30)
tree.addChild(childValue: 40)
var treeNode = TreeNode<Int>(value: 100)
treeNode.addChild(childValue: 200)
treeNode.addChild(childValue: 300)
treeNode.addChild(childValue: 400)
tree.addChildNode(node: treeNode)
print(tree)
var searchValue = 20
print("Node for \(searchValue) -> \(String(describing: tree.search(searchValue)))")
searchValue = 800
print("Node for \(searchValue) -> \(String(describing: tree.search(searchValue)))")
searchValue = 300
print("Node for \(searchValue) -> \(tree.search(searchValue))")


//Graph Example
var graph = Graph<Int>()
graph.addVertex(data: 1)
graph.addVertex(data: 2)
graph.addEdge(type: .directed, from: 1, to: 2, weight: 10)
graph.addEdge(type: .directed, from: 3, to: 4, weight: 30)
graph.addEdge(type: .directed, from: 2, to: 1, weight: 10)
graph.addEdge(type: .undirected, from: 6, to: 7, weight: 70)
graph.addEdge(type: .undirected, from: 6, to: 9, weight: 80)
graph.addEdge(type: .undirected, from: 7, to: 9, weight: 50)
graph.addEdge(type: .undirected, from: 7, to: 11, weight: 60)
graph.addEdge(type: .undirected, from: 8, to: 9, weight: 90)
graph.addEdge(type: .undirected, from: 10, to: 11, weight: 110)
graph.edges(from: 1)
graph.edges(from: 6)
graph.weight(from: 1, to: 2)
graph.weight(from: 6, to: 7)
graph.weight(from: 6, to: 11)
print(graph.description)


//BFS
let vault = Graph<String>()

let entranceRoom = vault.addVertex(data: "Entrance")
let spiderRoom = vault.addVertex(data: "Spider")
let goblinRoom = vault.addVertex(data: "Goblin")
let ratRoom = vault.addVertex(data: "Rat")
let knightRoom = vault.addVertex(data: "Knight")
let batRoom = vault.addVertex(data: "Bat")
let orcRoom = vault.addVertex(data: "Orc")
let keyRoom = vault.addVertex(data: "Key")
let treasureRoom = vault.addVertex(data: "Treasure")

vault.addEdge(type: .undirected, from: entranceRoom.data, to: spiderRoom.data, weight: 1)
vault.addEdge(type: .undirected, from: entranceRoom.data, to: ratRoom.data, weight: 1)
vault.addEdge(type: .undirected, from: entranceRoom.data, to: batRoom.data, weight: 1)
vault.addEdge(type: .undirected, from: spiderRoom.data, to: goblinRoom.data, weight: 1)
vault.addEdge(type: .undirected, from: spiderRoom.data, to: orcRoom.data, weight: 1)
vault.addEdge(type: .undirected, from: ratRoom.data, to: treasureRoom.data, weight: 1)
vault.addEdge(type: .undirected, from: ratRoom.data, to: keyRoom.data, weight: 1)
vault.addEdge(type: .undirected, from: batRoom.data, to: knightRoom.data, weight: 1)

if let edges = vault.breadthFirstSearch(from: entranceRoom, to: treasureRoom) {
    print("BFS-")
    for edge in edges {
        print("\(edge.source) -> \(edge.destination)")
    }
}


//DFS
let myGraph = Graph<String>()

let s = myGraph.addVertex(data: "S")
let a = myGraph.addVertex(data: "A")
let b = myGraph.addVertex(data: "B")
let c = myGraph.addVertex(data: "C")
let d = myGraph.addVertex(data: "D")
let f = myGraph.addVertex(data: "F")
let g = myGraph.addVertex(data: "G")
let e = myGraph.addVertex(data: "E")

myGraph.addEdge(type: .undirected, from: s.data, to: a.data)
myGraph.addEdge(type: .undirected, from: a.data, to: b.data)
myGraph.addEdge(type: .undirected, from: a.data, to: d.data)
myGraph.addEdge(type: .undirected, from: a.data, to: c.data)
myGraph.addEdge(type: .undirected, from: b.data, to: d.data)
myGraph.addEdge(type: .undirected, from: d.data, to: g.data)
myGraph.addEdge(type: .undirected, from: d.data, to: f.data)
myGraph.addEdge(type: .undirected, from: f.data, to: e.data)

let dfsVertices = myGraph.depthFirstSearch(from: s, to: e)
print("DFS path- \(dfsVertices.description)")

let arr = ["akash", "rastogi"]
arr.joined(separator: "\n")


//LRU Cache
let cache = LRUCache<Int>(2)
cache?.set(1, val: 1)
cache?.set(2, val: 2)
cache?.set(3, val: 3)
cache?.set(4, val: 4)

print(cache?.get(1))//nil
print(cache?.get(2))//nil
print(cache?.get(3))//3
print(cache?.get(4))//4

var hashTable = HashTable<String, String>.init(capacity: 3)
hashTable["firstName"] = "akash"
hashTable["lastName"] = "rastogi"
hashTable["city"] = "gurgaon"
print(hashTable["firstName"])
