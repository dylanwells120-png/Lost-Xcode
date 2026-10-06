/// How Rose is moving. Drives speed and how much noise she makes.
public enum MovementMode: Equatable {
    case idle, crouch, walk, run

    /// Metres per second.
    public var speed: Float {
        switch self {
        case .idle: return 0
        case .crouch: return 1.0
        case .walk: return 2.0
        case .run: return 4.0
        }
    }

    /// Radius in metres within which Hollow can hear Rose.
    public var noiseRadius: Float {
        switch self {
        case .idle: return 0
        case .crouch: return 2
        case .walk: return 6
        case .run: return 14
        }
    }

    /// Picks a mode from analogue stick magnitude (0...1) and the run / crouch buttons.
    public static func from(stickMagnitude: Float, running: Bool, crouching: Bool) -> MovementMode {
        guard stickMagnitude > 0.1 else { return .idle }
        if crouching { return .crouch }
        if running { return .run }
        return .walk
    }
}
