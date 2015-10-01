// In one of the lectures we saw switching on strings when handling seques.
// In general, communicating with strings is a very bad idea. 
// This translates strings to happiness in a centralized way to avoid typos.
// This also uses raw values on enums to translate a happiness to a happiness value

enum Happiness : Int {
    case Happy = 100
    case Sad = 0
    case Meh = 50
    
    static func fromString(input: String) -> Happiness? {
        switch input.lowercaseString {
        case "happy": return .Happy
        case "sad": return .Sad
        case "meh": return .Meh
        default: return nil
        }
    }
}

// Usage
func doSomethingBasedOnHappiness(happinessString: String) {
    guard let hapiness = Happiness.fromString(happinessString) else {
        print("Everything went wrong, we're so sad.")
        return
    }
    switch(hapiness) { // No default case! This is handled by optionals.
    case .Happy: return // Do something when Happy
    case .Meh: return // Do something when Meh
    case .Sad: return // Do something when Sad
    }
}

func getHappinessValue(happinessString: String) -> Int? {
    return Happiness.fromString(happinessString)?.rawValue
}
