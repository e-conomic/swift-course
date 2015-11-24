import Foundation

class Human: NSObject {
    
    var name: String
    
    var friend:Human?
    
    weak var weakFriend:Human?
    
    // Strong reference to his arm
    var leftArm:HumanArm?
    
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
    
    override var description: String {
        return name
    }
}
