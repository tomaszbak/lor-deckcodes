public enum Faction: Int {
    case demacia = 0
    case freljord = 1
    case ionia = 2
    case noxus = 3
    case piltoverAndZaun = 4
    case shadowIsles = 5
    case bilgewater = 6
    case targon = 9
}

extension Faction: CustomStringConvertible {
    public var description: String {
        switch self {
        case .demacia: return "DE"
        case .freljord: return "FR"
        case .ionia: return "IO"
        case .noxus: return "NX"
        case .piltoverAndZaun: return "PZ"
        case .shadowIsles: return "SI"
        case .bilgewater: return "BW"
        case .targon: return "MT"
        }
    }
}
