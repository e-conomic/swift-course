import UIKit
import Foundation
/*:
## Optional types
My own implementation of optional strings
*/
enum MyOptionalString {
    case Nil
    case MyString(string:String)
}
var myOptionalString = MyOptionalString.MyString(string: "foo")
switch myOptionalString {
case .Nil: print("Handle nil string")
case .MyString(let myUnwrappedString): print("We have: \(myUnwrappedString)")
}

//: Swift's implementation of optionals
var optionalString:String? = "foo"
if let unwrappedString = optionalString {
    print("We have \(unwrappedString)")
} else {
    print("Handle nil string")
}

//: Guards (Swift 2.0) Golden path
func guardExample() {
    guard let unwrappedString = optionalString else {
        print("Handle nil string");
        return
    }
    print("We have \(unwrappedString)")
}
guardExample()
























/*:
Structs, like classes they have
* properties
* methods
* subscripts
* initializers
* extentions
* protocols

But cannot:
* inheritance
* be type casted
* deinitialized
* no ARC i.e. no multiple referencing

Structs (like enums) are value types. This means they always copied when passed around,
 e.g. passed to a function or assigned to a varialbe or constant

Example of build in structs  

* integer
* booleans
* floats
* string
* arrays 
* dictionaries
*/
struct MyStruct {
    var foo = ""
}
let myStruct = MyStruct(foo: "foo")

//: Value types
func setFooTo42(var copyOfMyStruct: MyStruct) {
    copyOfMyStruct.foo = "42"
    copyOfMyStruct.foo
}
setFooTo42(myStruct)
myStruct.foo // Still foo

// Do the "same" but with a class
class MyClass {
    var foo = ""
}
let myClass = MyClass()
myClass.foo = "foo"

//: Reference types
func setFooTo42(myReferenceType: MyClass) {
    myReferenceType.foo = "42"
    myReferenceType.foo
}
setFooTo42(myClass)
myClass.foo // Is 42


























/*:
Enums and the switch control flow
*/
enum Shape {
    case Square
    case Triangle
    case Pentagon(String)
    
    func indexName() -> String {
        switch self {
        case .Square: return "s"
        case .Triangle: return "t"
        case .Pentagon(let associatedValue): return associatedValue
        }
    }
}
let shape:Shape = .Pentagon("p")

//: Tree datastructure with recursive enums
indirect enum Tree {
    case Leaf(Int)
    case Node(Tree, Tree)
    
    var sumTree: Int {
        switch self {
        case .Leaf(let value): return value
        case let .Node(left, right): return left.sumTree + right.sumTree
        }
    }
}
let tree = Tree.Node(.Leaf(1), .Node(.Leaf(2), .Leaf(3)))
print(tree.sumTree) // 1 + (2 + 3) = 6























/*:
Closures
*/
var addTo42: Int -> Int = { val in
    return 42 + val
}
addTo42(1)

//: Using closures and functions as arguments (Higher Order Functions)
var arr = [1, 2, 3]
func combine(result: Int, withElement element: Int) -> Int {
    return result + element
}
arr.reduce(0, combine: combine)
arr.reduce(0, combine: { res, elm in res + elm } )
arr.reduce(0) { res, elm in res + elm }
arr.reduce(0) { $0 + $1 }
arr.reduce(0, combine: +)

var numbersAsStrings = arr.map { String($0) }

var aboveOnes = arr.filter { $0 > 1 }

















/*:
Tuples
*/
var tup = (17, 42, 300)
let aa = tup.0, bb = tup.1, cc = tup.2

//: Named tuples
var namedTup = (dog: "Fido", age: 12)
namedTup.dog
namedTup.age

/*: Return tuples from functions.
note: example of when you might wants this
*/
func returnTuples() -> (Int, Shape) {
    return (42, Shape.Triangle)
}
let (truth, someShape) = returnTuples()
switch returnTuples() {
case (42, .Square): print("nope")
case (42, .Triangle): print("Hello")
case (_, _): print("catch all")
}


















//: The where keyword
var val: Int? = nil
if let theTruthAboutEverything = val where val != 42 {
    print("\(val) is not the truth about everything")
}

//: In loops
for val in 1...10 where val % 2 == 0 {
    print("even \(val)")
}

//: Use where in switches
switch val {
case let theTruth where theTruth == 42: print("The truth is \(theTruth)")
default: ()
}


















//: Extensions
extension String {
    func concatFoo() -> String {
        return self + "foo"
    }
}
"foo".concatFoo()


















/*:
Protocols, think interfaces in e.g. Java C#
Protocols can them selves have extensions (Abstract classes)
*/
protocol Fooable {
    func foo() -> String
}
//: Conform to a protocol. Inheritance from NSObject
class FooImplementer: Fooable {
    // Required
    func foo() -> String {
        return "foo"
    }
}


/*:
Optional definitions in protocols
Requires the @objc attribute - Obj-C legacy resons
Requires implementing class to inherit from NSObject as well
*/
@objc protocol OptionalFooable {
    optional func foo() -> String
}
//: Conform to a protocol. Inheritance from NSObject
class OptionalFooImplementer: OptionalFooable {
    // Not required
//    @objc func foo() -> String {
//        return "foo"
//    }
}



















//: Subscripting e.g. implementing obj[<some indexer>] on objects
class IntTable {
    private var table = [[1,2,3], [4,5,6], [7,8,9]]
    
    subscript(x: Int, y: Int) -> Int {
        get {
            return table[x][y]
        }
        set {
            table[x][y] = newValue
        }
    }
}
var myIntTable = IntTable()
myIntTable[2,2]
myIntTable[2,2] = 42
myIntTable[2,2]





















//: Identity operators
class Dummy { }
let dummyObj = Dummy()
dummyObj === dummyObj
dummyObj !== Dummy()

//: Equality operations and override
class DummyEquals: NSObject {
    var value = 0
    
    override func isEqual(otherObject: AnyObject?) -> Bool {
        if let object = otherObject as? DummyEquals {
            return value == object.value
        }
        return false
    }
    
    override var description:String {
        return "dummy \(value)"
    }
}
var dummy1 = DummyEquals()
var dummy2 = DummyEquals()
dummy1.value = 42
dummy2.value = 42
dummy1 == dummy2
// but
dummy1 === dummy2

























/*:
Lazy loaded properties
Syntactic sugar for how one would normally
implement lazy loading.
*/
class LazyProperties {
    
    private var lazyProperty:String?
    func getLazyProperty() -> String {
        if lazyProperty == nil {
            lazyProperty = "lazy"
        }
        return lazyProperty!
    }
    
    // Exactly the same as getLazyProperty, with syntactic sugar
    lazy var lazyProperty2:String = {
        return "lazy"
    }()
}
var lp = LazyProperties()
lp.lazyProperty2





























//: Error handling
enum MyError: ErrorType {
    case MyError1
    case MyError2
}

func throwException() throws -> String {
    defer {
        print("ALWAYS called at the end of the function")
    }
    
    throw MyError.MyError2
}

do {
    try throwException()
    print("More statements here if no exception")
} catch MyError.MyError1 {
    print("Caught \(MyError.MyError1)")
} catch MyError.MyError2 {
    print("Caught \(MyError.MyError2)")
} catch {
    print("catch all")
}

//: Handling exceptions as optionals
if let x = try? throwException() {
    print("No exception thrown, and we do not care about what actual exception is thrown")
}





















/*:
Extras, see the SwiftLanguage playground.
*/
func mySort(@noescape compare: (Int, Int) -> Bool) {
    var nums = [3,1,2]
    // sortInPlace also takes a @noescape closure
    return nums.sortInPlace(compare)
}

// Custom prefix operator with unicode
prefix operator √ {}
prefix func √ (number: Double) -> Double {
    return sqrt(number)
}
√64
