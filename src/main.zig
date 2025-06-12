const std = @import("std");
const lib = @import("pong_lib");
const rl = @import("raylib");

pub fn main() !void {
    const width = 800;
    const height = 450;

    rl.initWindow(width, height, "Pong");
    defer rl.closeWindow();

    rl.setTargetFPS(60);

    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(rl.Color.sky_blue);
        std.debug.print("Current FPS: {}\n", .{rl.getFPS()});
    }
}
