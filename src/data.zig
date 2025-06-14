//! This file contains the game data struct that gets passed around
const std = @import("std");
const rl = @import("raylib");

pub const Scenes = enum { Title, Game };

pub const GAME_DATA = struct {
    // Window height/width; gets updated every frame
    height: i32 = 800,
    width: i32 = 450,
    title: [:0]const u8 = "Pong",

    leftPaddle: ?*rl.Rectangle = null,
    rightPaddle: ?*rl.Rectangle = null,

    // Random number generator
    rand: *const std.Random,

    // Game state
    currentScene: Scenes = .Title,
    firstDraw: bool = true,
    leftScore: u32 = 0,
    rightScore: u32 = 0,
};
