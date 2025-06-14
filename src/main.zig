const std = @import("std");

const lib = @import("pong_lib");
const rl = @import("raylib");

pub fn main() !void {
    var prng = std.Random.DefaultPrng.init(blk: {
        var seed: u64 = undefined;
        std.posix.getrandom(std.mem.asBytes(&seed)) catch unreachable;
        break :blk seed;
    });
    var data: lib.GAME_DATA = lib.GAME_DATA{ .rand = &prng.random() };

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

        var buf: [100]u8 = undefined;
        const scores = try std.fmt.bufPrintZ(&buf, "{} | {}", .{ data.leftScore, data.rightScore });
        rl.drawText(scores, @divFloor(data.width - 125, 2), 50, 48, rl.Color.black);

        // Clear screen and set background to white
        rl.clearBackground(rl.Color.white);
    }
}
