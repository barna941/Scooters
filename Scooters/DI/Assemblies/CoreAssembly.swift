import Swinject

struct CoreAssembly: Assembly {
    func assemble(container: Container) {
        container.register(LocationServiceProtocol.self) { _ in
            LocationService()
        }.inObjectScope(.container)
    }
}
