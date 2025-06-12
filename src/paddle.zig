const rl = @import("raylib");

pub const paddle = struct {
    const PADDLE_HEIGHT = 100;
    const PADDLE_WIDTH = 10;

    var paddleLeft = rl.Rectangle{ .x = 0, .y = 0, .height = PADDLE_HEIGHT, .width = PADDLE_WIDTH };
    pub fn drawPaddleLeft() void {
        rl.drawRectangleRec(paddleLeft, rl.Color.blue);
    }

    var paddleRight = rl.Rectangle{ .x = 0, .y = 0, .height = PADDLE_HEIGHT, .width = PADDLE_WIDTH };
    pub fn drawPaddleRight(WIDTH: i32) void {
        paddleRight.x = @floatFromInt(WIDTH - PADDLE_WIDTH);
        rl.drawRectangleRec(paddleRight, rl.Color.red);
    }
};
