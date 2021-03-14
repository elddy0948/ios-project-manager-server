import Vapor

func routes(_ app: Application) throws {
    app.http.server.configuration.hostname = "example.herokuapp.com"
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }
}
