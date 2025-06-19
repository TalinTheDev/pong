//! This file holds util functions for this library

/// Float from int
pub fn fti(int: i32) f32 {
    return @as(f32, @floatFromInt(int));
}

/// Int from float
pub fn itf(float: f32) i32 {
    return @as(i32, @intFromFloat(float));
}
