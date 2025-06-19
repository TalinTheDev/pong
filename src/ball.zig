//! This file holds the logic for the ball
const rl = @import("raylib");
const std = @import("std");
const lib_data = @import("data.zig");
const lib = @import("utils.zig");

pub const ball = struct {
    // Ball related constants/variables
    const RADIUS = 25;
    const BALL_VELOCITY = 300;

    var ball_negate_x: i8 = 1; // When flipped to -1, ball changes direction (x)
    var ball_negate_y: i8 = 1; // When flipped to -1, ball changes direction (y)
    // Starting position of ball is estimated center of the screen
    var center: rl.Vector2 = rl.Vector2{ .x = 350, .y = 200 };

    /// Draws the ball onto the screen
    /// Takes in a HEIGHT & WIDTH, each representing the current height/width of the window
    /// Calculates collisions and moves ball appropriately
    /// Finally draws the ball orange
    pub fn drawBall(data: *lib_data.GAME_DATA) void {
        if (data.firstDraw) {
            center = rl.Vector2{
                .x = lib.fti(@divFloor(data.width, 2) + RADIUS),
                .y = lib.fti(@divFloor(data.height, 2) + RADIUS),
            };
            ball_negate_x = if (data.rand.boolean()) 1 else -1;
            ball_negate_y = if (data.rand.boolean()) 1 else -1;
            data.firstDraw = false;
            rl.drawCircleV(center, RADIUS, rl.Color.orange);
            return;
        }
        // Get movement delta using frame time (also known as delta time)
        const ball_delta: i32 = lib.itf(BALL_VELOCITY * rl.getFrameTime());

        // Window collision checking
        if (center.y > lib.fti(data.height - RADIUS))
            ball_negate_y = -1;
        if (center.x > lib.fti(data.width - RADIUS)) {
            // Restart game and add 1 point for left
            data.firstDraw = true;
            data.leftScore += 1;
        }
        if (center.y < lib.fti(0 + RADIUS))
            ball_negate_y = 1;
        if (center.x < lib.fti(0 + RADIUS)) {
            // Restart game and add 1 point for right
            data.firstDraw = true;
            data.rightScore += 1;
        }

        // Paddle collision checking
        if (rl.checkCollisionCircleRec(center, RADIUS, data.leftPaddle.?.*)) {
            ball_negate_x = 1;
        } else if (rl.checkCollisionCircleRec(center, RADIUS, data.rightPaddle.?.*)) {
            ball_negate_x = -1;
        }

        // Calculate new position based on the delta and collision checks
        center.x += lib.fti(ball_negate_x * ball_delta);
        center.y += lib.fti(ball_negate_y * ball_delta);

        // Draw ball orange
        rl.drawCircleV(center, RADIUS, rl.Color.orange);
    }
};
