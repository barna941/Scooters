import Alamofire
import Swinject

final class Dependencies {
    private static let dependencies = Dependencies()
    private let container = Container()
    private lazy var assembler = Assembler(container: container)
}

extension Dependencies {
    static var resolver: Resolver { dependencies.container }

    static func registerServices() {
        dependencies.assembler.apply(
            assemblies: [
                NetworkAssembly(),
                HomeAssembly()
            ]
        )
    }
}
