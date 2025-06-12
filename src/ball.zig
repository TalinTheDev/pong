const rl = @import("raylib");

pub const ball = struct {
    const BALL_VELOCITY = 400;
    var ball_negate: i8 = 1;
    var x: i32 = 375;
    var y: i32 = 200;

    pub fn drawBall(HEIGHT: i32, WIDTH: i32) void {
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
    }
};
