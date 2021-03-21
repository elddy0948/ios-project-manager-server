import Fluent

struct CreateHistory: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.enum("status")
            .case("todo")
            .case("doing")
            .case("done")
            .create()
            .flatMap { status in
                database.enum("Behavior")
                    .case("moved")
                    .case("added")
                    .case("removed")
                    .create()
                    .flatMap { behavior in
                        database.schema("histories")
                            .id()
                            .field("title", .string, .required)
                            .field("fromStatus", status, .required)
                            .field("toStatus", status, .required)
                            .field("behavior", behavior, .required)
                            .field("modifiedDate", .datetime, .required)
                            .create()
                    }
            }
    }
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("histories").delete()
    }
}
