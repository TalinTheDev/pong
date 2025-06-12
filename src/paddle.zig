const rl = @import("raylib");

pub const paddle = struct {
    const PADDLE_HEIGHT = 100;
    const PADDLE_WIDTH = 10;

    var paddleLeft = rl.Rectangle{ .x = 0, .y = 0, .height = PADDLE_HEIGHT, .width = PADDLE_WIDTH };
    pub fn drawPaddleLeft(HEIGHT: i32) void {
        if (rl.isKeyDown(rl.KeyboardKey.w) and paddleLeft.y > 0) {
            paddleLeft.y -= 10;
        } else if (rl.isKeyDown(rl.KeyboardKey.s) and @as(i32, @intFromFloat(paddleLeft.y)) + PADDLE_HEIGHT <= HEIGHT) {
            paddleLeft.y += 10;
        }
        rl.drawRectangleRec(paddleLeft, rl.Color.blue);
    }

    var paddleRight = rl.Rectangle{ .x = 0, .y = 0, .height = PADDLE_HEIGHT, .width = PADDLE_WIDTH };
    pub fn drawPaddleRight(HEIGHT: i32, WIDTH: i32) void {
        paddleRight.x = @floatFromInt(WIDTH - PADDLE_WIDTH);

        if (rl.isKeyDown(rl.KeyboardKey.up) and paddleRight.y > 0) {
            paddleRight.y -= 10;
        } else if (rl.isKeyDown(rl.KeyboardKey.down) and @as(i32, @intFromFloat(paddleRight.y)) + PADDLE_HEIGHT <= HEIGHT) {
            paddleRight.y += 10;
        }

        rl.drawRectangleRec(paddleRight, rl.Color.red);
    }
};
