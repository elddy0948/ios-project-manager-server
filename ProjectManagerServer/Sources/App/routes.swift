import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }
    
    //Create
    app.post("api", "todos") { (req) -> EventLoopFuture<Todo> in
        let todo = try req.content.decode(Todo.self)
        return todo.save(on: req.db).map {
            let history = History(title: "ADDED \(todo.title)",
                                  fromStatus: .todo, toStatus: .done,
                                  behavior: .added, modifiedDate: todo.date)
            history.save(on: req.db)
            return todo
        }
    }
    
    app.post("api", "histories") { req -> EventLoopFuture<History> in
        let history = try req.content.decode(History.self)
        return history.save(on: req.db).map {
            history
        }
    }
    
    //Get all Todos
    app.get("api", "todos") { (req) -> EventLoopFuture<[Todo]> in
        return Todo.query(on: req.db).all()
    }
    
    app.get("api", "histories") { req -> EventLoopFuture<[History]> in
        return History.query(on: req.db).all()
    }
}
