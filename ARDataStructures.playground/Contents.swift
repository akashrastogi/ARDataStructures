//: Playground - noun: a place where people can play

import Foundation

//Stack example
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
