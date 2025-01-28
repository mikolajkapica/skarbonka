import Foundation

enum Tabs {
    case home
    case games
    case profile
    
    var title: String {
        switch self {
        case .home: String(localized: "Oszczędzanie")
        case .games: String(localized: "Gry")
        case .profile: String(localized: "Profil")
        }
    }
    
    func icon(isSelected: Bool) -> String {
        switch self {
        case .home: isSelected ? "piggy-active" : "piggy"
        case .games: isSelected ? "play-active" : "play"
        case .profile: isSelected ? "profile-active" : "profile"
        }
    }
} 