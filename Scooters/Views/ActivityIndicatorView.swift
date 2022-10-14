import UIKit

final class ActivityIndicatorView: UIView {
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = Asset.Colors.accent.color
        return indicator
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        customizeViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func customizeViews() {
        backgroundColor = Asset.Colors.primaryBackground.color
        layer.cornerRadius = 16
        layer.masksToBounds = true
        addSubview(activityIndicator.usingAutoLayout())
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            indicatorConstraints()
        ])
    }

    private func indicatorConstraints() -> [NSLayoutConstraint] {
        [
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
    }
}

extension ActivityIndicatorView {
    func startAnimating() {
        activityIndicator.startAnimating()
    }

    func stopAnimating() {
        activityIndicator.stopAnimating()
    }
}
