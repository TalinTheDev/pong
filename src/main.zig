//! Main game file
const std = @import("std");
const lib = @import("pong_lib");
const rl = @import("raylib");

/// Function to draw the actual game
fn gameScene(data: *lib.GAME_DATA) !void {
    // Draw game objects
    lib.paddle.drawPaddleLeft(data);
    lib.paddle.drawPaddleRight(data);
    lib.ball.drawBall(data);

    // Create buffer to write game score to
    var buf: [100]u8 = undefined;
    const scores = try std.fmt.bufPrintZ(&buf, "{} | {}", .{ data.leftScore, data.rightScore });
    const scoreSize: i32 = 48;
    rl.drawText(scores, @divFloor(data.width - rl.measureText(scores, scoreSize), 2), 50, scoreSize, rl.Color.black);
}

fn titleScene(data: *lib.GAME_DATA) !void {
    // Draw title
    const titleText = "Welcome to Pong!";
    const titleSize: i32 = 64;
    const titleX = @divFloor(data.width - rl.measureText(titleText, titleSize), 2);
    const titleY = @divFloor(data.height - 64, 2);
    rl.drawText(titleText, titleX, titleY, titleSize, rl.Color.black);

    // Draw start button
    const buttonOffsetY: f32 = 75.0;
    const buttonOffsetX: f32 = lib.fti(rl.measureText(titleText, titleSize) - 100) / 2.0;
    const playButton = rl.Rectangle{
        .x = lib.fti(titleX) + buttonOffsetX,
        .y = lib.fti(titleY) + buttonOffsetY,
        .height = 75,
        .width = 100,
    };
    rl.drawRectangleRec(playButton, rl.Color.sky_blue);

    // Draw text inside button
    const playText = "Play";
    const playSize: i32 = 28;
    rl.drawText(playText, lib.itf(playButton.x) + 25, lib.itf(playButton.y) + 25, playSize, rl.Color.black);

    if (rl.checkCollisionPointRec(rl.getMousePosition(), playButton) and rl.isMouseButtonReleased(rl.MouseButton.left)) {
        // Start game
        data.currentScene = .Game;
    }
}

pub fn main() !void {
    // Init random number generator
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
