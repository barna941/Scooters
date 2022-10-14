import UIKit

final class VehicleDetailsViewController: UIViewController {
    private let presenter: VehicleDetailsPresenterProcotol

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [typeLabel, batteryLabel, helmetLabel, speedLabel])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    private let typeLabel = UILabel()
        .with(textColor: Asset.Colors.textPrimary.color)
        .with(font: .regular, size: .body1)

    private let batteryLabel = UILabel()
        .with(textColor: Asset.Colors.textPrimary.color)
        .with(font: .regular, size: .body1)

    private let helmetLabel = UILabel()
        .with(textColor: Asset.Colors.textPrimary.color)
        .with(font: .regular, size: .body1)

    private let speedLabel = UILabel()
        .with(textColor: Asset.Colors.textPrimary.color)
        .with(font: .regular, size: .body1)

    init(presenter: VehicleDetailsPresenterProcotol) {
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        customizeViews()
        setupConstraints()
        bindPresenter()

        presenter.viewDidLoad()
    }

    private func customizeViews() {
        title = L10n.vehicleDetailsTitle
        view.backgroundColor = Asset.Colors.primaryBackground.color

        view.addSubview(stackView.usingAutoLayout())
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackViewConstraints()
        ])
    }

    private func stackViewConstraints() -> [NSLayoutConstraint] {
        [
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
    }

    private func bindPresenter() {
        presenter.vehicleReceived = { [weak self] vehicleViewModel in
            self?.configure(with: vehicleViewModel)
        }
    }

    private func configure(with viewModel: VehicleDetailsViewModel) {
        typeLabel.text = viewModel.type
        batteryLabel.text = viewModel.batteryLevel
        helmetLabel.text = viewModel.helmetBoxText
        speedLabel.text = viewModel.maxSpeed
    }
}
