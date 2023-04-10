//: [Previous](@previous)

import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

// removeDuplicates
let words = "hey hey there! Mr Mr ?"
    .components(separatedBy: " ")
    .publisher // ["hey", "hey", "there!", "Mr", "Mr", "?"]
words
    .removeDuplicates()
    .sink { value in
        print(value)
    }.store(in: &subscriptions)
//hey
//there!
//Mr
//?
// compactMap

let strings = ["a", "1.24", "3", "def", "45", "0.23"].publisher
//let float = Float("a") // 변환이 안되니 nil을 return함
strings
    .compactMap { Float($0) }
    .sink { value in
        print(value)
    }.store(in: &subscriptions)
//1.24
//3.0
//45.0
//0.23

// ignoreOutput
let numbers = (1...10_000).publisher

numbers
    .ignoreOutput()
    .sink(receiveCompletion: { print("Completed with: \($0)") }, receiveValue: { print($0) })
    .store(in: &subscriptions)
//ignorOutput은 출력을 무시
//Completed with: finished
// prefix
let tens = (1...10).publisher
tens
    .prefix(2)
    .sink(receiveCompletion: { print("Competed with: \($0)") }, receiveValue: { print($0) })
    .store(in: &subscriptions)
//1
//2
//Competed with: finished
//원하는 개수만큼만 가져옴
//: [Next](@next)
