enum TabBarPage {
    case ready
    case steady
    case go

    init?(index: Int) {
        switch index {
        case 0:
            self = .ready
        case 1:
            self = .steady
        case 2:
            self = .go
        default:
            return nil
        }
    }
    
    func pageTitleValue() -> String {
        switch self {
        case .ready:
            return "Airport"
        case .steady:
            return "Global"
        case .go:
            return "My profile"
        }
    }

    func pageOrderNumber() -> Int {
        switch self {
        case .ready:
            return 0
        case .steady:
            return 1
        case .go:
            return 2
        }
    }
    
    func pageImage() -> String? {
        switch self {
        case .ready:
            return "Vector-2"
        case .steady:
            return nil
        case .go:
            return "Layer"
        }
    }
}
