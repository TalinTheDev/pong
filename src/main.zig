const std = @import("std");

const lib = @import("pong_lib");
const rl = @import("raylib");

var data: lib.GAME_DATA = lib.GAME_DATA{};

pub fn main() !void {
    // Init Game
    rl.initWindow(data.height, data.width, data.title);
    defer rl.closeWindow();

    rl.setTargetFPS(60);

    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();

        // Get window details
        data.height = rl.getRenderHeight();
        data.width = rl.getRenderWidth();

        // Draw game objects
        lib.paddle.drawPaddleLeft(&data);
        lib.paddle.drawPaddleRight(&data);
        lib.ball.drawBall(&data);

        // Clear screen and set background to white
        rl.clearBackground(rl.Color.white);
    }
}
