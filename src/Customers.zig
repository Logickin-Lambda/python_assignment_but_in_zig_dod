const std = @import("std");

// Here are all the required tables and maps for the Customer database
pub var names: std.AutoHashMap(u32, []const u8) = undefined;
pub var lkup: std.StringHashMap(u32) = undefined;

/// there is no value in the set, but since zig currently has no hashset
/// I decided to fill that a zero for now. I know this is not a good practice
/// because the value is now unused, but I don't want to waste time on creating
/// a half-baked hashset while the main point of this project is about the
/// thinking process of using Data Oriented Design, so let us be gaslit
/// with thinking these are "hashset" for now until there is a good
/// built-in implementation.
pub var basic_set: std.AutoHashMap(u32, u32) = undefined;
pub var vip_set: std.AutoHashMap(u32, u32) = undefined;

pub var reward_rates: std.AutoHashMap(u32, f64) = undefined;
pub var rewards: std.AutoHashMap(u32, f64) = undefined;
pub var discount: std.AutoHashMap(u32, f64) = undefined;

pub fn init(allocator: std.mem.Allocator) void {
    names = std.AutoHashMap(u32, []const u8).init(allocator);
    lkup = std.StringHashMap(u32).init(allocator);
    basic_set = std.AutoHashMap(u32, u32).init(allocator);
    vip_set = std.AutoHashMap(u32, u32).init(allocator);
    reward_rates = std.AutoHashMap(u32, f64).init(allocator);
    rewards = std.AutoHashMap(u32, f64).init(allocator);
    discount = std.AutoHashMap(u32, f64).init(allocator);
}

pub fn deinit() void {
    names.deinit();
    lkup.deinit();
    basic_set.deinit();
    vip_set.deinit();
    reward_rates.deinit();
    rewards.deinit();
    discount.deinit();
}

/// I decided to hardcode the data here to skip the
/// file io process because this is not
/// the point of the project
pub fn load_data() !void {
    // import names
    try names.put(1, "James");
    try names.put(2, "Lily");
    try names.put(3, "Tom");
    try names.put(5, "Harry");
    try names.put(8, "Annie");
    try names.put(10, "Sarah");
    try names.put(11, "Wilson");

    // import lkup
    try lkup.put("James", 1);
    try lkup.put("Lily", 2);
    try lkup.put("Tom", 3);
    try lkup.put("Harry", 5);
    try lkup.put("Annie", 8);
    try lkup.put("Sarah", 10);
    try lkup.put("Wilson", 11);

    // basic and VIP users:
    try basic_set.put(1, 0);
    try basic_set.put(2, 0);
    try basic_set.put(5, 0);
    try basic_set.put(10, 0);
    try basic_set.put(11, 0);

    try vip_set.put(3, 0);
    try vip_set.put(8, 0);

    // reward and reward rates
    try reward_rates.put(1, 1);
    try reward_rates.put(2, 1);
    try reward_rates.put(3, 1);
    try reward_rates.put(5, 1);
    try reward_rates.put(8, 1);
    try reward_rates.put(10, 1);
    try reward_rates.put(11, 1);

    try rewards.put(1, 10);
    try rewards.put(2, 36);
    try rewards.put(3, 12);
    try rewards.put(5, 61);
    try rewards.put(8, 45);
    try rewards.put(10, 32);
    try rewards.put(11, 26);

    // discounts if there is one:
    try discount.put(3, 0.08);
    try discount.put(8, 0.1);
}
