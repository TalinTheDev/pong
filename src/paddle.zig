const rl = @import("raylib");

pub const paddle = struct {
    // Paddle related constants
    const PADDLE_HEIGHT = 100;
    const PADDLE_WIDTH = 10;
    const PADDLE_MOVE = 10;

    // The two Rectangles that represent each paddle (identical at first)
    var paddleLeft = rl.Rectangle{ .x = 0, .y = 0, .height = PADDLE_HEIGHT, .width = PADDLE_WIDTH };
    var paddleRight = rl.Rectangle{ .x = 0, .y = 0, .height = PADDLE_HEIGHT, .width = PADDLE_WIDTH };

    /// Draws the left paddle.
    /// Takes in a HEIGHT which represents the window height
    /// Uses keyboard input (W/S) to move paddle and performs collision checking
    /// Then moves & draws the paddle blue
    pub fn drawPaddleLeft(HEIGHT: i32) void {
        // Move paddle based on W/S and perform window collision checking
        if (rl.isKeyDown(rl.KeyboardKey.w) and paddleLeft.y > 0) {
            paddleLeft.y -= PADDLE_MOVE;
        } else if (rl.isKeyDown(rl.KeyboardKey.s) and @as(i32, @intFromFloat(paddleLeft.y)) + PADDLE_HEIGHT <= HEIGHT) {
            paddleLeft.y += PADDLE_MOVE;
        }

        // Draw the paddle blue
        rl.drawRectangleRec(paddleLeft, rl.Color.blue);
    }

    /// Draws the right paddle on the right side of the screen.
    /// Takes in a HEIGHT & WIDTH which represents the window height/width
    /// Uses keyboard input (UP/DOWN) to move paddle and performs collision checking
    /// Then moves & draws the paddle red
    pub fn drawPaddleRight(HEIGHT: i32, WIDTH: i32) void {
        // Move paddle to the right
        paddleRight.x = @floatFromInt(WIDTH - PADDLE_WIDTH);

        // Move paddle based on UP/DOWN and preform window collision checking
        if (rl.isKeyDown(rl.KeyboardKey.up) and paddleRight.y > 0) {
            paddleRight.y -= 10;
        } else if (rl.isKeyDown(rl.KeyboardKey.down) and @as(i32, @intFromFloat(paddleRight.y)) + PADDLE_HEIGHT <= HEIGHT) {
            paddleRight.y += 10;
        }

        // Draw the paddle red
        rl.drawRectangleRec(paddleRight, rl.Color.red);
    }
};
