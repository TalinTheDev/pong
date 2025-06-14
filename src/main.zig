const std = @import("std");

const lib = @import("pong_lib");
const rl = @import("raylib");

fn gameScene(data: *lib.GAME_DATA) !void {
    // Draw game objects
    lib.paddle.drawPaddleLeft(data);
    lib.paddle.drawPaddleRight(data);
    lib.ball.drawBall(data);

    var buf: [100]u8 = undefined;
    const scores = try std.fmt.bufPrintZ(&buf, "{} | {}", .{ data.leftScore, data.rightScore });
    const scoreSize: i32 = 48;
    rl.drawText(scores, @divFloor(data.width - rl.measureText(scores, scoreSize), 2), 50, scoreSize, rl.Color.black);
}

fn titleScene(data: *lib.GAME_DATA) !void {
    const titleText = "Welcome to Pong!";
    const titleSize: i32 = 64;
    const titleX = @divFloor(data.width - rl.measureText(titleText, titleSize), 2);
    const titleY = @divFloor(data.height - 64, 2);
    rl.drawText(titleText, titleX, titleY, titleSize, rl.Color.black);

    const buttonOffsetY: f32 = 75.0;
    const buttonOffsetX: f32 = @as(f32, @floatFromInt(rl.measureText(titleText, titleSize) - 100)) / 2.0;
    const playButton = rl.Rectangle{ .x = @as(f32, @floatFromInt(titleX)) + buttonOffsetX, .y = @as(f32, @floatFromInt(titleY)) + buttonOffsetY, .height = 75, .width = 100 };
    rl.drawRectangleRec(playButton, rl.Color.sky_blue);
    const playText = "Play";
    const playSize: i32 = 28;
    rl.drawText(playText, @as(i32, @intFromFloat(playButton.x)) + 25, @as(i32, @intFromFloat(playButton.y)) + 25, playSize, rl.Color.black);

    if (rl.checkCollisionPointRec(rl.getMousePosition(), playButton) and rl.isMouseButtonReleased(rl.MouseButton.left)) {
        data.currentScene = .Game;
    }
}

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

        if (data.currentScene == .Title) {
            try titleScene(&data);
        } else if (data.currentScene == .Game) {
            try gameScene(&data);
        }

        // Clear screen and set background to white
        rl.clearBackground(rl.Color.white);
    }
}
