import Fluent
import Vapor

enum Status: String, Codable {
    case todo, doing, done
}

final class Todo: Model, Content {
    static let schema: String = "todos"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "description")
    var description: String
    
    @Field(key: "date")
    var date: Date
    
    @Enum(key: "status")
    var status: Status
    
    init() { }
    
    init(id: UUID? = nil, title: String, description: String, date: Date, status: Status) {
        self.id = id
        self.title = title
        self.description = description
        self.date = date
        self.status = status
    }
}
