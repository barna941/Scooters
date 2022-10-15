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

    private let warningLabel = UILabel()
        .with(textColor: Asset.Colors.alert.color)
        .with(font: .bold, size: .body1)
        .with(textAlignment: .center)
        .with(text: L10n.locationDisabledWarning)

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
    }

    private func customizeViews() {
        title = L10n.vehicleDetailsTitle
        view.backgroundColor = Asset.Colors.primaryBackground.color
        warningLabel.isHidden = true

        view.addSubview(stackView.usingAutoLayout())
        view.addSubview(warningLabel.usingAutoLayout())
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackViewConstraints(),
            warningLabelConstraints()
        ])
    }

    private func bindPresenter() {
        presenter.viewModelReceived = { [weak self] viewModel in
            self?.configure(with: viewModel)
        }
    }

    private func configure(with viewModel: VehicleDetailsViewModel) {
        switch viewModel {
        case .disabled:
            warningLabel.isHidden = false
            stackView.isHidden = true

        case .enabled(let vehicle):
            warningLabel.isHidden = true
            stackView.isHidden = false
            typeLabel.text = vehicle.type
            batteryLabel.text = vehicle.batteryLevel
            helmetLabel.text = vehicle.helmetBoxText
            speedLabel.text = vehicle.maxSpeed
        }
    }
}

// MARK: - Layout

extension VehicleDetailsViewController {
    private func stackViewConstraints() -> [NSLayoutConstraint] {
        [
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
    }

    private func warningLabelConstraints() -> [NSLayoutConstraint] {
        [
            warningLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            warningLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            warningLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            warningLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24)
        ]
    }
}
