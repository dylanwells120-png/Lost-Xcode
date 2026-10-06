/// A sound made in the world at a position (x, z on the ground plane).
public struct NoiseEvent: Equatable {
    public var x: Float
    public var z: Float
    public var radius: Float

    public init(x: Float, z: Float, radius: Float) {
        self.x = x
        self.z = z
        self.radius = radius
    }

    /// True if a listener at (x, z) with the given hearing multiplier can hear this noise.
    public func isAudible(atX lx: Float, z lz: Float, hearing: Float = 1) -> Bool {
        guard radius > 0 else { return false }
        let dx = lx - x, dz = lz - z
        let reach = radius * hearing
        return dx * dx + dz * dz <= reach * reach
    }
}
