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
            todo
        }
    }
    
    //Get all Todos
    app.get("api", "todos") { (req) -> EventLoopFuture<[Todo]> in
        return Todo.query(on: req.db).all()
    }
}
