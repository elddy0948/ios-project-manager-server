//"index": "48E2E85B-9FC4-4FA7-AE98-D0F2BE71AF10",
//        "title": "Moved '아침먹기' from TODO to DOING.",
//        "fromStatus": "todo",
//        "toStatus": "doing",
//        "behavior": "moved",
//        "modifiedDate": "2020-04-03T00:00:00Z"
import Vapor
import Fluent

enum Behavior: String, Codable {
    case moved, added, removed
}

final class History: Model, Content {
    static let schema: String = "histories"
    
    @ID
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Enum(key: "fromStatus")
    var fromStatus: Status
    
    @Enum(key: "toStatus")
    var toStatus: Status
    
    @Enum(key: "behavior")
    var behavior: Behavior
    
    @Field(key: "modifiedDate")
    var modifiedDate: Date
    
    init() { }
    
    init(id: UUID? = nil, title: String, fromStatus: Status, toStatus: Status, behavior: Behavior, modifiedDate: Date) {
        self.id = id
        self.title = title
        self.fromStatus = fromStatus
        self.toStatus = toStatus
        self.behavior = behavior
        self.modifiedDate = modifiedDate
    }
}
