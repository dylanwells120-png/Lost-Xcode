import XCTest
@testable import LostCore

final class LostCoreTests: XCTestCase {
    func testModeSelection() {
        XCTAssertEqual(MovementMode.from(stickMagnitude: 0, running: true, crouching: false), .idle)
        XCTAssertEqual(MovementMode.from(stickMagnitude: 1, running: false, crouching: false), .walk)
        XCTAssertEqual(MovementMode.from(stickMagnitude: 1, running: true, crouching: false), .run)
        XCTAssertEqual(MovementMode.from(stickMagnitude: 1, running: true, crouching: true), .crouch)
    }

    func testRunningIsLouderThanCrouching() {
        XCTAssertGreaterThan(MovementMode.run.noiseRadius, MovementMode.crouch.noiseRadius)
    }

    func testNoiseAudibility() {
        let noise = NoiseEvent(x: 0, z: 0, radius: 6)
        XCTAssertTrue(noise.isAudible(atX: 3, z: 0))
        XCTAssertFalse(noise.isAudible(atX: 10, z: 0))
        XCTAssertTrue(noise.isAudible(atX: 10, z: 0, hearing: 2))
    }

    func testHollowInvestigatesThenReturnsToPatrol() {
        var brain = HollowBrain(searchDuration: 2)
        brain.hear(NoiseEvent(x: 1, z: 1, radius: 6), position: (0, 0))
        XCTAssertEqual(brain.state, .investigate)
        brain.reachedTarget()
        XCTAssertEqual(brain.state, .search)
        brain.update(deltaTime: 2.5)
        XCTAssertEqual(brain.state, .patrol)
    }

    func testRunningNoiseTriggersChase() {
        var brain = HollowBrain()
        brain.hear(NoiseEvent(x: 5, z: 0, radius: 14), position: (0, 0))
        XCTAssertEqual(brain.state, .chase)
    }
}
