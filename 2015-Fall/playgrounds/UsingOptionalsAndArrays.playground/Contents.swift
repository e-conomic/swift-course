// Not all methods on arrays are safe to blindly use.
// Some, such as removeFirst(), have implicit requirements.
// This is easy to forget, and can easily be avoided using extensions.
// Here we extend arrays by adding a new method called removeFirst() returning an optional.
// This means that if the array is empty, we get nil, rather than the entire program crashing.
// Since this is an extension we can reuse it everywhere in our program, instead of constantly checking for the array lenght.

extension Array {
    mutating public func removeFirst() -> Element? {
        if(self.count > 0) {
            return self.removeFirst()
        } else {
            return nil
        }
    }
}

var array = [String]()

if let first = array.removeFirst() {
    print(first)
}else {
    print("Handling")
}