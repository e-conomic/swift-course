class HumanArm {
    
    // A HumanArm connot exist without a Human.
    // If so, if a living arm attempts to access the human
    // we want to program to crash
    unowned var human:Human
    
    let armName:String
    
    init(human: Human) {
        self.human = human
        self.armName = self.human.name + "'s arm"
        print("Initialized \(self.human.name)'s arm")
    }
    
    deinit {
        print("Deinitialized \(armName)")
    }
}
