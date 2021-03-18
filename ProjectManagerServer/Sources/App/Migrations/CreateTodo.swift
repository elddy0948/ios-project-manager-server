import Fluent

struct CreateTodo: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.enum("Status")
            .case("todo")
            .case("doing")
            .case("done")
            .create()
            .flatMap { (status) in
                return database.schema("todos")
                    .id()
                    .field("title", .string, .required)
                    .field("description", .string, .required)
                    .field("date", .datetime, .required)
                    .field("status", status, .required)
                    .create()
            }
    }
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("todos").delete()
    }
}
