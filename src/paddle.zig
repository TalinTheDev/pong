//! This file holds the logic for the paddles
const rl = @import("raylib");
const lib_data = @import("data.zig");
const lib = @import("utils.zig");

pub const paddle = struct {
    // Paddle related constants
    const PADDLE_HEIGHT = 100;
    const PADDLE_WIDTH = 10;
    const PADDLE_MOVE = 10;

    // The two Rectangles that represent each paddle (identical at first)
    var leftPaddle = rl.Rectangle{ .x = 0, .y = 0, .height = PADDLE_HEIGHT, .width = PADDLE_WIDTH };
    var rightPaddle = rl.Rectangle{ .x = 0, .y = 0, .height = PADDLE_HEIGHT, .width = PADDLE_WIDTH };

    /// Draws the left paddle.
    /// Takes in a HEIGHT which represents the window height
    /// Uses keyboard input (W/S) to move paddle and performs collision checking
    /// Then moves & draws the paddle blue
    pub fn drawPaddleLeft(data: *lib_data.GAME_DATA) void {
        // Make sure the left paddle is in the game data struct
        if (data.leftPaddle == null)
            data.leftPaddle = &leftPaddle;

        // Move paddle based on W/S and perform window collision checking
        if (rl.isKeyDown(rl.KeyboardKey.w) and leftPaddle.y > 0) {
            leftPaddle.y -= PADDLE_MOVE;
        } else if (rl.isKeyDown(rl.KeyboardKey.s) and lib.itf(leftPaddle.y) + PADDLE_HEIGHT <= data.height) {
            leftPaddle.y += PADDLE_MOVE;
        }

        // Draw the paddle blue
        rl.drawRectangleRec(leftPaddle, rl.Color.blue);
    }

    /// Draws the right paddle on the right side of the screen.
    /// Takes in a HEIGHT & WIDTH which represents the window height/width
    /// Uses keyboard input (UP/DOWN) to move paddle and performs collision checking
    /// Then moves & draws the paddle red
    pub fn drawPaddleRight(data: *lib_data.GAME_DATA) void {
        // Make sure the right paddle is in the game data struct
        if (data.rightPaddle == null)
            data.rightPaddle = &rightPaddle;

        // Move paddle to the right
        rightPaddle.x = lib.fti(data.width - PADDLE_WIDTH);

        // Move paddle based on UP/DOWN and preform window collision checking
        if (rl.isKeyDown(rl.KeyboardKey.up) and rightPaddle.y > 0) {
            rightPaddle.y -= 10;
        } else if (rl.isKeyDown(rl.KeyboardKey.down) and lib.itf(rightPaddle.y) + PADDLE_HEIGHT <= data.height) {
            rightPaddle.y += 10;
        }

        // Draw the paddle red
        rl.drawRectangleRec(rightPaddle, rl.Color.red);
    }
};
