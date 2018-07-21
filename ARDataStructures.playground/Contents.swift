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


