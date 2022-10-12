import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    private var appCoordinator: AppCoordinator?

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        Dependencies.registerServices()

        window = UIWindow(frame: UIScreen.main.bounds)
        appCoordinator = AppCoordinator(window: window)
        appCoordinator?.start()

        return true
    }
}
