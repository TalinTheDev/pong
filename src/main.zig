const std = @import("std");

const lib = @import("pong_lib");
const rl = @import("raylib");

const BALL_VELOCITY = 500;

pub fn main() !void {
    rl.initWindow(800, 450, "Pong");
    defer rl.closeWindow();

    rl.setTargetFPS(60);

    var ball_negate: i8 = 1;
    var x: i32 = 375;
    var y: i32 = 200;
    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();

        const WIDTH = rl.getRenderWidth();
        const HEIGHT = rl.getRenderHeight();

        const ball_delta: i32 = @intFromFloat(BALL_VELOCITY * rl.getFrameTime());
        x = x + (ball_negate * ball_delta);
        y = y + (ball_negate * ball_delta);

        if (y > HEIGHT)
            ball_negate = -1;
        if (x > WIDTH)
            ball_negate = -1;
        if (y < 0)
            ball_negate = 1;
        if (x < 0)
            ball_negate = 1;

        rl.drawCircle(x, y, 25, rl.Color.orange);

        rl.clearBackground(rl.Color.white);
    }
}
