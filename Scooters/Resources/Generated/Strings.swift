// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Vehicles
  internal static let homeTitle = L10n.tr("Localizable", "home_title", fallback: "Vehicles")
  /// km/h
  internal static let kilometersPerHour = L10n.tr("Localizable", "kilometers_per_hour", fallback: "km/h")
  /// Location services are disabled
  internal static let locationDisabledWarning = L10n.tr("Localizable", "location_disabled_warning", fallback: "Location services are disabled")
  /// An error occured during network communication
  internal static let networkError = L10n.tr("Localizable", "network_error", fallback: "An error occured during network communication")
  /// OK
  internal static let okTitle = L10n.tr("Localizable", "ok_title", fallback: "OK")
  /// An error occured
  internal static let otherError = L10n.tr("Localizable", "other_error", fallback: "An error occured")
  /// %%
  internal static let percent = L10n.tr("Localizable", "percent", fallback: "%%")
  /// Has helmetbox
  internal static let vehicleDetailsHasHelmetbox = L10n.tr("Localizable", "vehicle_details_has_helmetbox", fallback: "Has helmetbox")
  /// Without helmetbox
  internal static let vehicleDetailsHasNoHelmetbox = L10n.tr("Localizable", "vehicle_details_has_no_helmetbox", fallback: "Without helmetbox")
  /// Closest vehicle
  internal static let vehicleDetailsTitle = L10n.tr("Localizable", "vehicle_details_title", fallback: "Closest vehicle")
  /// Ebicyle
  internal static let vehicleTypeEbicyle = L10n.tr("Localizable", "vehicle_type_ebicyle", fallback: "Ebicyle")
  /// Emoped
  internal static let vehicleTypeEmoped = L10n.tr("Localizable", "vehicle_type_emoped", fallback: "Emoped")
  /// Escooter
  internal static let vehicleTypeEscooter = L10n.tr("Localizable", "vehicle_type_escooter", fallback: "Escooter")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
