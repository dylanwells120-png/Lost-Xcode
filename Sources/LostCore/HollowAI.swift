/// Behaviour states for a Hollow (see GAME_DESIGN.md, Enemy Types).
public enum HollowState: Equatable {
    case idle, patrol, investigate, chase, search
}

/// Minimal Hollow brain. Hears noise, investigates, and gives up after a while.
public struct HollowBrain {
    public private(set) var state: HollowState = .patrol
    public private(set) var target: (x: Float, z: Float)?
    /// Multiplies how far this Hollow can hear (Listeners > 1).
    public var hearing: Float
    /// Seconds spent searching before returning to patrol.
    public var searchDuration: Float
    private var searchTimer: Float = 0

    public init(hearing: Float = 1, searchDuration: Float = 5) {
        self.hearing = hearing
        self.searchDuration = searchDuration
    }

    /// Call when a noise happens. `position` is this Hollow's location.
    public mutating func hear(_ noise: NoiseEvent, position: (x: Float, z: Float)) {
        guard noise.isAudible(atX: position.x, z: position.z, hearing: hearing) else { return }
        target = (noise.x, noise.z)
        // Loud noises (running) trigger a chase, quieter ones an investigation.
        state = noise.radius >= 10 ? .chase : .investigate
        searchTimer = 0
    }

    /// Call when the Hollow reaches its target or loses it.
    public mutating func reachedTarget() {
        guard state == .investigate || state == .chase else { return }
        state = .search
        searchTimer = 0
    }

    /// Advance timers.
    public mutating func update(deltaTime: Float) {
        guard state == .search else { return }
        searchTimer += deltaTime
        if searchTimer >= searchDuration {
            state = .patrol
            target = nil
        }
    }
}
