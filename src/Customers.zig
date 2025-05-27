const std = @import("std");

// Here are all the required tables and maps for the Customer database
var names: std.AutoHashMap(u32, []const u8) = undefined;
var lkup: std.AutoHashMap([]const u8, u32) = undefined;

/// there is no value in the set, but since zig currently has no hashset
/// I decided to fill that a zero for now. I know this is not a good practice
/// because the value is now unused, but I don't want to waste time on creating
/// a half-baked hashset while the main point of this project is about the
/// thinking process of using Data Oriented Design, so let us be gaslit
/// with thinking these are "hashset" for now until there is a good
/// built-in implementation.
var basic_set: std.AutoHashMap(u32, u32) = undefined;
var vip_set: std.AutoHashMap(u32, u32) = undefined;

const Reward = struct { rate: f64, amount: f64 };
var rewards: std.AutoHashMap(u32, Reward) = undefined;
var discount: std.AutoHashMap(u32, f64) = undefined;

pub fn init(allocator: std.mem.Allocator) void {
    names = std.AutoHashMap(u32, []const u8).init(allocator);
    lkup = std.AutoHashMap([]const u8, u32).init(allocator);
    basic_set = std.AutoHashMap(u32, u32).init(allocator);
    vip_set = std.AutoHashMap(u32, u32).init(allocator);
    rewards = std.AutoHashMap(u32, Reward).init(allocator);
    discount = std.AutoHashMap(u32, f64).init(allocator);
}

pub fn deinit() void {
    names.deinit();
    lkup.deinit();
    basic_set.deinit();
    vip_set.deinit();
    rewards.deinit();
    discount.deinit();
}
