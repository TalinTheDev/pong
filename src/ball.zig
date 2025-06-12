const rl = @import("raylib");

pub const ball = struct {
    // Ball related constants/variables
    const RADIUS = 25;
    const BALL_VELOCITY = 400;

    var ball_negate: i8 = 1; // When flipped to -1, ball changes direction
    var x: i32 = 375; // Starting position is center of default screen width
    var y: i32 = 200; // Starting position is center of default screen height

    /// Draws the ball onto the screen
    /// Takes in a HEIGHT & WIDTH, each representing the current height/width of the window
    /// Calculates collisions and moves ball appropriately
    /// Finally draws the ball orange
    pub fn drawBall(HEIGHT: i32, WIDTH: i32) void {
        // Get movement delta using frame time (also known as delta time)
        const ball_delta: i32 = @intFromFloat(BALL_VELOCITY * rl.getFrameTime());

        // Window collision checking
        if (y > HEIGHT - RADIUS)
            ball_negate = -1;
        if (x > WIDTH - RADIUS)
            ball_negate = -1;
        if (y < 0 + RADIUS)
            ball_negate = 1;
        if (x < 0 + RADIUS)
            ball_negate = 1;

        // Calculate new position based on the delta and collision checks
        x = x + (ball_negate * ball_delta);
        y = y + (ball_negate * ball_delta);

        // Draw ball orange
        rl.drawCircle(x, y, RADIUS, rl.Color.orange);
    }
};
