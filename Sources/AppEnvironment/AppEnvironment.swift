import Foundation

public enum AppEnvironment: CustomStringConvertible {

  nonisolated(unsafe) public static let current = AppEnvironment()

  case debug
  case forceDebug
  case enterpriseRelease
  case storeRelease

  public var description: String {
    switch self {
    case .debug:        return "Debug (likely local Xcode build)"
    case .forceDebug:   return "Force Debug (TestFlight build used together with PerformanceCompanion app)"
    case .enterpriseRelease: return "Enterprise (most likely an internal store build)"
    case .storeRelease: return "Store (either a testflight or actual appstore release)"
    }
  }

  public var isDebuggingEnabled: Bool {
    switch self {
    case .debug, .forceDebug, .enterpriseRelease:
      return true
    case .storeRelease:
      return false
    }
  }

  private init() {
    #if DEBUG
    self = .debug
    #elseif ENTERPRISE
    self = .adhocRelease
    #elseif RELEASE
    self = .storeRelease
    #else
    fatalError("Invalid project configuration")
    #endif
  }

  public static var isSimulator: Bool {
    #if targetEnvironment(simulator)
    return true
    #else
    return false
    #endif
  }
}
