import Swinject

struct CoreAssembly: Assembly {
    func assemble(container: Container) {
        container.register(LocationServiceProtocol.self) { _ in
            LocationService()
        }.inObjectScope(.container)
        container.register(VehicleRepositoryServiceProtocol.self) { _ in
            VehicleRepositoryService()
        }.inObjectScope(.container)
        container.register(VehicleFinderServiceProtocol.self) { _ in
            VehicleFinderService()
        }
    }
}
