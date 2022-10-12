import Swinject

// swiftlint:disable identifier_name
struct NetworkAssembly: Assembly {
    func assemble(container: Container) {
        container.register(NetworkClientProtocol.self) { _ in
            NetworkClient()
        }
        container.register(ScootersApiProtocol.self) { r in
            ScootersApi(netwworkClient: r.resolve(NetworkClientProtocol.self)!)
        }
    }
}
