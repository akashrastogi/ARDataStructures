//: Playground - noun: a place where people can play

import Foundation

//Stack example
//pile of dinner plates, moulded chairs are real world example of Stack
//Back/Forward stacks on browsers are examples of Stack
var techStack = ARStack<String>()
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
var personQueue = ARQueue<String>()
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
let playerList = ARLinkedList<String>()
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
var tree = ARTreeNode<Int>(value: 10)
tree.addChild(childValue: 20)
tree.addChild(childValue: 30)
tree.addChild(childValue: 40)
var treeNode = ARTreeNode<Int>(value: 100)
treeNode.addChild(childValue: 200)
treeNode.addChild(childValue: 300)
treeNode.addChild(childValue: 400)
tree.addChildNode(node: treeNode)
print(tree)
var searchValue = 20
print("Node for \(searchValue) -> \(tree.search(searchValue))")
searchValue = 800
print("Node for \(searchValue) -> \(tree.search(searchValue))")
searchValue = 300
print("Node for \(searchValue) -> \(tree.search(searchValue))")

