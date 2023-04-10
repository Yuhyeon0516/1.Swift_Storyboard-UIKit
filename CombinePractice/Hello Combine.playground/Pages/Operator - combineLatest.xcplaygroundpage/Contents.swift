//: [Previous](@previous)

import Foundation
import Combine


// Basic CombineLatest
let strPublisher = PassthroughSubject<String, Never>()
let numPublisher = PassthroughSubject<Int, Never>()

//                1초	2초	    3초	    4초  	5초  	6초
//strPublisher    "a"			        "b"	    	    "c"
//numPublisher		    1	    2	    3	    4	    5
//결과	        	    "a"1    "a"2	"b"3	"b"4	"c"5

strPublisher.combineLatest(numPublisher).sink { (str, num) in
    print("Receive: \(str), \(num)")
}
//strPublisher.send("a")
//strPublisher.send("b")
//strPublisher.send("c")
// 출력 없음
//numPublisher.send(1)
//numPublisher.send(2)
//numPublisher.send(3)
//Receive: c, 1
//Receive: c, 2
//Receive: c, 3

strPublisher.send("a")
numPublisher.send(1)
strPublisher.send("b")
strPublisher.send("c")
numPublisher.send(2)
numPublisher.send(3)
//Receive: a, 1
//Receive: b, 1
//Receive: c, 1
//Receive: c, 2
//Receive: c, 3

// Advanced CombineLatest
let usernamePublisher = PassthroughSubject<String, Never>()
let passwordPublisher = PassthroughSubject<String, Never>()
let validatedCrendetialsSubscription = usernamePublisher.combineLatest(passwordPublisher)
    .map{ (username, password) -> Bool in
        return !username.isEmpty && !password.isEmpty && password.count > 12
    }
    .sink { valid in
        print("Credential valid? : \(valid)")
    }
usernamePublisher.send("yuhyeonkim")
//passwordPublisher.send("weekpw")
//Credential valid? : false
passwordPublisher.send("verystrongpassword")
//Credential valid? : true
//CombineLatest는 두개의 Data가 모두 입력이 들어올때 sink가 동작함

// Merge
let publisher1 = [1, 2, 3, 4, 5].publisher
let publisher2 = [300, 400, 500].publisher

let mergePublisher = publisher1.merge(with: publisher2)
    .sink { value in
        print("Merge: subscription recevied value: \(value)")
    }
//Merge: subscription recevied value: 1
//Merge: subscription recevied value: 2
//Merge: subscription recevied value: 3
//Merge: subscription recevied value: 4
//Merge: subscription recevied value: 5
//Merge: subscription recevied value: 300
//Merge: subscription recevied value: 400
//Merge: subscription recevied value: 500
//Publisher type이 같을 때만 Merge가능
//: [Next](@next)
