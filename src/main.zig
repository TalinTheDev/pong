const std = @import("std");

const lib = @import("pong_lib");
const rl = @import("raylib");

pub fn main() !void {
    rl.initWindow(800, 450, "Pong");
    defer rl.closeWindow();

    rl.setTargetFPS(60);

    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();

        const HEIGHT = rl.getRenderHeight();
        const WIDTH = rl.getRenderWidth();

        lib.ball.drawBall(HEIGHT, WIDTH);

        const rec: rl.Rectangle = rl.Rectangle{
            .x = 0,
            .y = 0,
            .height = 100,
            .width = 10,
        };
        rl.drawRectangleRec(rec, rl.Color.blue);

        rl.clearBackground(rl.Color.white);
    }
}
