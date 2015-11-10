import Foundation

print("hellp world")

// Constants string of type String
let foo:String = "foo"
// foo = "" // Not allowed, it's a constant

// Inferred type is String
let bar = "bar"

// Variable of type String
var baz = "baz"
baz = "" // ok

// Optionals
var optionalString:String?
optionalString = "os"


// if control flow
// booleans
if true == false {} else if "baz" == "foo" {} else { print("here") }

// Assertions
assert(true == true, "message")

// Optional unwrapping
if let unwrappedOptional = optionalString {
    // unwrappedOptional is of type String
}

// Explicit unwrapping
var str: String = optionalString!

// Array
var arr = [1, 2, 3]
var arr2 = arr + arr

// Dictionaries of <String, String>
var d = [String:String]()
d = Dictionary<String, String>() // same
d["a"] = "123"
var nubers = [0: "zero", 1: "one", 2: "two"]

// Sets
var s:Set<Int> = [1, 2, 3]
s.insert(42) // union, intersect, contains..

// Function that takes a String and returns a String
// The arrow points to the return type
func concatBar(string: String) -> String {
    return string + "bar"
}

// Calling a function.
concatBar("bar")

// Internal and external parameter naming in functions
func appendBar2(externalName internalName:String) -> String {
    return internalName + "bar2"
}
// Parameter name is not explicti
appendBar2(externalName: "foo")

// Mor arguments
func addYears(years:Int, toYear:Int) {
    // Passing arguments to strings
    print("Computed year \(years + toYear)")
}
addYears(42, toYear:1900)

// Loops
for i in 1...10 {
    var a = pow(Double(i), 2)
}

for elm in [1,2,3] {}

var b = true
var dummy = 42
while b && dummy == 42 {
    b = false
}
// do while
repeat {
    print(dummy)
} while dummy != 42

// Functional
arr.forEach(
    { elm in
        // do stuff on elements
    })
// Or with syntactic sugar
arr.forEach {
        print($0)// 1,2,3
    }

// Reduce, equilavant statements
arr.reduce(0, combine: { res, elm in res + elm} )
arr.reduce(0) { res, elm in res + elm}
arr.reduce(0) { $0 + $1}
arr.reduce(0, combine:+)

var stringNumbers = arr.map { String($0) }

var aboveOnes = arr.filter { $0 > 1 }

// Closures
var closure = {
    return 42
}
closure()

// Nonescaping closures, e.g. not completion handlers
// allows for compiler optimizations and says that
// the closure's lifespan is that of the function execution
// i.e. we cannot store it, or pass it to some async jobs
// Good example: http://stackoverflow.com/questions/28427436/noescape-attribute-in-swift-1-2
func mySort(@noescape compare: (Int, Int) -> Bool) {
    var nums = [3,1,2]
    // sortInPlace takes a @noescape closure
    return nums.sortInPlace(compare)
}

// Autoclosures, expression is automatically converted to a closure
// Uncommen to implement and implies to @noescape attribute
// If it should be non escaping use @autoclosure(escaping)
var names = ["anders", "benny", "carsten"]
func printName(@autoclosure closure: () -> String) {
//    print("hello \(closure())");
    print("Not calling the closure names array is unchanged!")
}
printName(names.removeAtIndex(0))
print(names)

var completionHandler = { print(42); }
var storeClosureWontWork:[() -> ()] = []
func compileError(@noescape completion: () -> ()) {
//  Uncomment the following to see the compile error when trying to
//  store a @noescape closure
//    storeClosureWontWork.append(completion)
    completion()
}
compileError(completionHandler)

// Enums, switch control flow
enum Shape {
    case Square
    case Triangle, OtherShapeToDemoSingleLine
    case Pentagon(String)
    
    func indexName() -> String {
        switch self {
        case .Square: return "s"
        case .Triangle: return "t"
        case .Pentagon(let associatedValue): return associatedValue
        default: return "Switch must be exhaustive, we did not cover OtherShapeToDemoSingleLine"
        }
    }
}
let shape:Shape = .Pentagon("p")

// enum with default raw values
// raw values must be unique at compile time, unlike associated values
enum MyChar: Character {
    case Tab = "\t"
    case Foo = "f"
}
let char:Character = MyChar.Tab.rawValue
MyChar.Tab == MyChar(rawValue: "\t")


// Recursive enums, a tree data structure
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

// Golden path with `guard`
var opt:String? = "hi, I'm an optional"
guard let unwrappedOpt = opt else {
    print("Could not unwrap opt");
    exit(0)
}
print("opt=\(opt)")

// where
var val:Int? = 42
if let theTruthAboutEverything = val where val != 42 {
    print("\(val) is not the truth about everything")
    exit(0)
}

for x in arr where x > 2 {
    print(x)
}

// Tuples
// multiple declarations in one line
var tup = (17, 42, 300)
let aa = tup.0, bb = tup.1, cc = tup.2

// Classes and access control
class MyClass {
    internal class InnerClass {} // internal is default
    private class PrivateInnerClass {} // private to the SOURCE FILE
}

class SomeOtherClass {
    let c = MyClass()
    let ci = MyClass.InnerClass()
    private let cpi = MyClass.PrivateInnerClass()
}

// Extensions
extension String {
    func reverse() -> String {
        return characters.reduce("") { String($1) + $0 }
    }
}
"foo".reverse()

// Protocols, think interfaces in e.g. Java C#
// Requires the @objc attribute - Obj-C legacy resons
// Requires implementing class to inherit from NSObject as well
@objc protocol Fooable {
    func foo() -> String;
    optional func maybe() -> String;
}
// Conform to a protocol
// Inheritance from NSObject
class FooImplementer: NSObject, Fooable {
    // Required
    func foo() -> String {
        return "foo"
    }
    // func maybe() {} Not required
}

// Subscripting e.g. implementing obj[<some indexer>] on objects
class DummySubscript {
    var a = "foo", b = "bar"
    subscript(varName: String) -> String {
    get {
        if varName == "a" { return a }
        return b
    }
        set(newValue) {
            if varName == "a" {
                a = newValue
            } else {
                b = newValue
            }
        }
    }
    // We can declare multiple subscript, with any number of args
    subscript(index: Int, ignoredArg: Array<Int>) -> String {
    get{
        if index == 0 {
            return a
        }
        return b
        }
        // readonly
    }
}
var obj = DummySubscript()
obj["a"]
obj["a"] = "baz"
obj[0, [42]]
obj["b"]

// Structs, like classes they have
// - properties, methods, subscripts, initializers, extentions, conform to protocols
// But cannot:
// - inheritance, be type casted, deinitialized, no ARC i.e. no multiple referencing
// Structs (like enums) are value typed
// This means they always copiedwhen passed around, 
// e.g. passed to a function or assigned to a varialbe or constant
// interger, booleans, floats, string, arrays, and dictionaries are structs behind the scenes.
struct MyStruct {
    var foo = "foo"
    let i = 42
}
let myStruct = MyStruct(foo: "auto generated init")

// Demo value typed arrays, i.e. that they are structs
var arrayStruct = [1, 2, 3]
func myNiceFunc(var arr: Array<Int>) {
    arr[0] = 42
}
myNiceFunc(arrayStruct)
arrayStruct[0] // still 1

// Identity operators === and !==
class Dummy { }
let dummyObj = Dummy()
dummyObj === dummyObj
dummyObj !== Dummy()

// Equality operations == and !=
// Making objects hashable
class DummyEquals: NSObject {
    var value = 0
    override func isEqual(otherObject: AnyObject?) -> Bool {
        if let object = otherObject as? DummyEquals {
            return value == object.value
        }
        return false
    }
    override var hash: Int {
        return value.hashValue
    }
}
var x = DummyEquals()
var y = DummyEquals()
x.value = 42
y.value = 42
x == y
// but
x !== y
