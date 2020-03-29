public enum Faction: Int {
    case demacia
    case freljord
    case ionia
    case noxus
    case piltoverAndZaun
    case shadowIsles
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
        }
    }
}
