//: [Previous](@previous)

import Foundation
import UIKit
import Combine

final class SomeViewMode {
    @Published var name: String = "Jack"
    var age: Int = 20
}

final class Label {
    var text: String = ""
}

let label = Label()
let vm = SomeViewMode()

print("text: \(label.text)")
vm.$name.assign(to: \.text, on: label)
print("text: \(label.text)")

vm.name = "Jason"
print("text: \(label.text)") //위에서 Jason을 넣고 label.text에 들어감

vm.name = "Hoo"
print("text: \(label.text)") //위에서 Hoo를 넣고 label.text에 들어감
//: [Next](@next)
