const std = @import("std");

const lib = @import("pong_lib");
const rl = @import("raylib");

pub fn main() !void {
    // Init Game
    rl.initWindow(800, 450, "Pong");
    defer rl.closeWindow();

    rl.setTargetFPS(60);

    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();

        // Get window details
        const HEIGHT = rl.getRenderHeight();
        const WIDTH = rl.getRenderWidth();

        // Draw game objects
        lib.ball.drawBall(HEIGHT, WIDTH);
        lib.paddle.drawPaddleLeft(HEIGHT);
        lib.paddle.drawPaddleRight(HEIGHT, WIDTH);

        // Clear screen and set background to white
        rl.clearBackground(rl.Color.white);
    }
}
