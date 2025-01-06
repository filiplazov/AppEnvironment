import Foundation

public enum AppEnvironment: CustomStringConvertible {

  nonisolated(unsafe) public static let current = AppEnvironment()

  case debug
  case forceDebug
  case enterpriseRelease
  case storeRelease

  public var description: String {
    switch self {
    case .debug:        return "Debug"
    case .forceDebug:   return "Force Debug"
    case .enterpriseRelease: return "Enterprise"
    case .storeRelease: return "Store"
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
