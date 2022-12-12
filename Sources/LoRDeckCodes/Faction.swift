extension Card {
    public enum Faction: Int {
        case demacia = 0
        case freljord = 1
        case ionia = 2
        case noxus = 3
        case piltoverAndZaun = 4
        case shadowIsles = 5
        case bilgewater = 6
        case shurima = 7
        case targon = 9
        case bandleCity = 10
        case runeterra = 12
    }
}

extension Card.Faction: CustomStringConvertible {
    public var description: String {
        switch self {
        case .demacia: return "DE"
        case .freljord: return "FR"
        case .ionia: return "IO"
        case .noxus: return "NX"
        case .piltoverAndZaun: return "PZ"
        case .shadowIsles: return "SI"
        case .bilgewater: return "BW"
        case .shurima: return "SH"
        case .targon: return "MT"
        case .bandleCity: return "BC"
        case .runeterra: return "RU"
        }
    }
}
