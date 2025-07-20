import Foundation

struct Task: Identifiable, Codable {
    let id = UUID()
    var title: String
    var isCompleted: Bool = false
    var priority: Priority = .medium
    var createdAt: Date = Date()
    var dueDate: Date?
    var notes: String = ""
    
    enum Priority: String, CaseIterable, Codable {
        case low = "Düşük"
        case medium = "Orta"
        case high = "Yüksek"
        
        var color: String {
            switch self {
            case .low:
                return "green"
            case .medium:
                return "orange"
            case .high:
                return "red"
            }
        }
        
        var sortOrder: Int {
            switch self {
            case .high:
                return 3
            case .medium:
                return 2
            case .low:
                return 1
            }
        }
    }
}