import Foundation

print("hell0 world")

// Operators
var i = 42
++i
--i
-i
+i
i++
i--
2 * 2
4 / 2
5 % 2
1+1
1-1
// With assignment
i *= 2
i /= 2
i %= 10
i += 1
i -= 1
// Comparisons
1 < 2
1 <= 1
2 > 1
1 >= 1
1 == 1
1 != 2
[1,2,3] ~= [1,2,3] // Pattern match

// Boolean operators
true && true
true || false
var res = nil ?? "it was nil"
true ? "true" : "false"

// Constant foo of type String is assigned "foo"
let foo: String = "foo"
// foo = "" // Not allowed, it's a constant

// Inferred type is String
let bar = "bar"

// Variable of type String
var baz = "baz"
baz = "" // ok

// Optionals
var optionalString: String?
optionalString = "os"


// If control flow
// Booleans
if true == false {} else if "baz" == "foo" {} else { print("here") }

// Assertions
assert(true == true, "message")

// Optional unwrapping
if let unwrappedOptional = optionalString {
    // unwrappedOptional is of type String
}

// Explicit unwrapping
var str: String = optionalString!

// Array - append, filter, flatMap, first, foreach, count, contains, endIndex, dropFirst, dropLast, isEmpty, map, last, maxElement, minElement, popLast, partition, removeAll, removeAtIndex, removeLast, removeFirst, removeRange, reverse, startIndex, startsWith
var arr = [1, 2, 3]
var arr2 = arr + arr

// Dictionaries of <String, String>
var d = [String:String]()
d = Dictionary<String, String>() // same
d["a"] = "123"
var numbers = [0: "zero", 1: "one", 2: "two"]

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
// Parameter name is not explicit
appendBar2(externalName: "foo")

// More arguments
func addYears(years:Int, toYear:Int) {
    // Passing arguments to strings
    print("Computed year \(years + toYear)")
}
addYears(42, toYear:1900)

// Loops
for i in 1...10 {
    var a = pow(Double(i), 2)
}

for elm in [1,2,3] { /* use elm */ }
for _ in 1...3 {} // _ is a wildcard, no element to use

var b = true
var dummy = 42
while b && dummy == 42 {
    b = false
}
// Do while
repeat {
    print(dummy)
} while dummy != 42

// Functional
arr.forEach({ elm in
    // do stuff on elements
})
// Or with syntactic sugar
arr.forEach {
    print($0) // 1,2,3
}

// Reduce, equilavant statements
func combine (result: Int, withElement element: Int) -> Int {
    return result + element
}
arr.reduce(0, combine: combine)
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
// Uncommon to implement and implies the @noescape attribute
// If it should be non-escaping use @autoclosure(escaping)
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

// Enum with default raw values
// Raw values must be unique at compile time, unlike associated values
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

// Tuples
// Multiple declarations in one line
var tup = (17, 42, 300)
let aa = tup.0, bb = tup.1, cc = tup.2

// Named tuples
var namedTup = (dog: "Fido", age: 12)
namedTup.dog // Returns "Fido"
namedTup.age // Returns 12

// Tuples in switches
let tuples = [(1,2), (17,42)][0]
switch tuples {
case (1, 2): () // Match some exact element, (and do nothing)
case (17, _): () // Match 17 in first position, and wildcard _
case (_, _): () // Match all
}

// Golden path with `guard`
var opt: String? = "Hi, I'm an optional"
guard let unwrappedOpt = opt else {
    print("Could not unwrap opt");
    exit(0)
}
print("unwrappedOpt=\(unwrappedOpt)")

// The where keyword
var val: Int? = 42
if let theTruthAboutEverything = val where val != 42 {
    print("\(val) is not the truth about everything")
    exit(0)
}

for val in 1...10 where [1,2,9].contains(val) && val < 7{
    print(val)
}

// Use where in switches
let name = "foo bar"
switch name {
case let barNamed where name.hasSuffix("bar"): print("\(barNamed) ends with bar")
default: ()
}

// Classes and access control
class MyClass {
    internal class InnerClass {} // Internal is default
    private class PrivateInnerClass {} // Private to the SOURCE FILE
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
        get {
            if index == 0 {
                return a
            }
            return b
        }
        // No set => readonly
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
// This means they always copied when passed around,
// e.g. passed to a function or assigned to a varialbe or constant
// interger, booleans, floats, string, arrays, and dictionaries are structs behind the scenes.
struct MyStruct {
    var foo = "foo"
    let i = 42
}
let myStruct = MyStruct(foo: "auto generated init")

// Demo value typed arrays, i.e. that they are structs
var arrayStruct = [1, 2, 3]
func setFirstValueInArrayTo42(var arr: Array<Int>) {
    arr[0] = 42
}
setFirstValueInArrayTo42(arrayStruct)
arrayStruct[0] // still 1

// The mutating keyword
// Mutate the properties of a struct from within
// Replace the struct by assigning to self
struct MutatingStruct {
    var x = 0
    mutating func mutateX(x: Int) {
        self.x = x
    }
    mutating func replaceSelf() {
        self = MutatingStruct(x: 123)
    }
}
// Must be var
var ms = MutatingStruct()
ms.mutateX(42)
ms.x
ms.replaceSelf()
ms.x // 123

// Mutating self on enums
enum MutatingEnum {
    case One, Two, Three
    mutating func inc(){
        switch self {
        case One: self = Two
        case Two: self = Three
        case Three: self = One
        }
    }
}
var mut = MutatingEnum.One
mut.inc() // Now mut == MutatingEnum.Two

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
var dummy1 = DummyEquals()
var dummy2 = DummyEquals()
dummy1.value = 42
dummy2.value = 42
dummy1 == dummy2
// but
dummy1 !== dummy2

// Computed properties, getters and setters
class ComputedProperties {
    
    var computedProperty: String {
        get {
            return self.computedProperty + String(random())
        }
        set {
            self.computedProperty = newValue + "adding foo"
        }
    }
}

// Lazy loaded properties
// Syntactic sugar for how one would normally
// implement lazy loading. 
// Can only be a var
class LazyProperties {
    
    private var lazyProperty:String?
    func getLazyProperty() -> String {
        if lazyProperty == nil {
            lazyProperty = "lazy"
        }
        return lazyProperty!
    }
    
    var callCount = 0
    // Exactly the same as getLazyProperty, with syntactic sugar
    lazy var lazyProperty2:String = {
        self.callCount++
        return "lazy \(self.callCount)"
    }()
}
var lp = LazyProperties()
lp.lazyProperty2
lp.callCount
lp.lazyProperty2
lp.callCount


// Observable properties
// Properties can be observable with didSet and willSet
// Can be used to 'react' (e.g. update your UI) when a variable changes
class ObservableExample {
    var current: String? {
        didSet {
            mirrored = current
        }
        willSet {
            latest = current
        }
    }
    
    var mirrored: String?
    var latest: String?
}

// Now 'latest' will contain the latest value set to 'current'
// while 'mirrored' will have the same value as 'current'
var observableExample = ObservableExample()
observableExample.current = "first"
observableExample.current == observableExample.mirrored
observableExample.latest == nil

observableExample.current = "second"
observableExample.current == observableExample.mirrored
observableExample.latest == "first"

// The observing and computing of properties
// can also be done with local variables
class ObservableLocalVariableExample {
    func foo() {
        var localVariable = 0 {
            didSet {
                print("local variable didset")
            }
        }
        localVariable = 42
    }
}
ObservableLocalVariableExample().foo()

// Type methods (class keyword) and static methods (static keyword)
// Main difference. Type methods are used in classes and can be overridden.
class StaticExample {
//    class let fooProp = "Not yet supported!"
    static let foo2Prop = "foo2Prop"
    class func foo() {
        print("Static thing in \(self)")
    }
    static func foo2() {
        print("also possible \(self)")
    }
}
StaticExample.foo2Prop;
StaticExample.foo();
StaticExample.foo2();
struct StaticExample2 {
    static let fooProp = "fooProp"
    static func foo() {
        print("Here 'class' could not have been used")
    }
}
StaticExample2.foo()
StaticExample2.fooProp

// Bitwise Operators
~3 // Bitwise not. 1 becomes 0, and 0 becomes 1
1 << 1 // Left shift
2 >> 1 // Right shift
1 & 3 // Bitwise AND
1 | 2 // Bitwise OR
1 ^ 3 // Bitwise XOR
// With assignment
var myInt = 42
myInt <<= 1
myInt >>= 1
myInt &= 1
myInt ^= 1
myInt |= 1
var myBool = true
// myBool &&= true // Logical AND (Not working in playground?)
// myBool ||= false // Logical OR (Not working in playground?)

// Operators that ignore overflows
2 &* UInt64.max // Multiplication
//2.0 &/ 0.001 // Division (Not working in playground?)
//&% // Remainder (Not working in playground?)
1 &+ UInt64.max // Addition
UInt64(0) &- 1 // Subtraction

// Custom operators
// Declare and infix operator ** to perform exponentiations
// Inside the {} we declare it to be left associative with precedence 160 (like << and >>)
infix operator ** { associativity left precedence 160 }
// Implementation
func ** (left: Double, right: Double) -> Double {
    return pow(left, right)
}
2 ** 6

// Also implement the assignment operator for **
infix operator **= { associativity right precedence 90 }
func **= (inout left: Double, right: Double) {
    left = left ** right
}
var aDouble = 2.0;
aDouble **= 3

// Custom prefix with unicode
prefix operator √ {}
prefix func √ (number: Double) -> Double {
    return sqrt(number)
}
√64

// Exceptions
enum MyError: ErrorType {
    case MyError1
    case MyError2
}

func throwException() throws -> String {
    var callOrder = 1
    // The defer statement does not seem to work in the playground
    defer {
        print("Will always be called by the end of a throwing function. callOrder=\(callOrder++)")
    }
    defer {
        print("More defer, called before the above. callOrder=\(callOrder++)")
    }
    throw MyError.MyError1
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

// Handling exceptions as optionals
if let x = try? throwException() {
    print("No exception thrown, and we do not care about what actual exception is thrown")
}

// Disabling Error propagatin
func wontThrow() throws -> String { return "" }
let iKnowItWillWork = try! wontThrow()

// The inout keyword.
func mutateSetFirstValueTo42(inout arr: [Int]) {
    arr[0] = 42
}
var arrToMutate = [1, 2, 3]
mutateSetFirstValueTo42(&arrToMutate)
arrToMutate[0] // 42

