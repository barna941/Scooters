import Swinject

// swiftlint:disable identifier_name
struct NetworkAssembly: Assembly {
    func assemble(container: Container) {
        container.register(NetworkClientProtocol.self) { _ in
            NetworkClient()
        }
        container.register(VehiclesApiProtocol.self) { r in
            VehiclesApi(
                netwworkClient: r.resolve(NetworkClientProtocol.self)!,
                baseUrlProvider: r.resolve(BaseUrlProviderProtocol.self)!
            )
        }
        container.register(BaseUrlProviderProtocol.self) { _ in
            BaseUrlProvider()
        }
    }
}
