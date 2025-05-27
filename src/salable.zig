const std = @import("std");

// Here are all the required tables and maps for the Customer database
var names: std.AutoHashMap(u32, []const u8) = undefined;
var lkup: std.AutoHashMap([]const u8, u32) = undefined;

var product_set: std.AutoHashMap(u32, u32) = undefined;
var prescription_set: std.AutoHashMap(u32, u32) = undefined;

var bundles: std.AutoHashMap(u32, std.ArrayList(u32)) = undefined;
var product_costs: std.AutoHashMap(u32, f64) = undefined;

pub fn init(allocator: std.mem.Allocator) void {
    names = std.AutoHashMap(u32, []const u8).init(allocator);
    lkup = std.AutoHashMap([]const u8, u32).init(allocator);
    product_set = std.AutoHashMap(u32, u32).init(allocator);
    prescription_set = std.AutoHashMap(u32, u32).init(allocator);
    bundles = std.AutoHashMap(u32, std.ArrayList(u32)).init(allocator);
    product_costs = std.AutoHashMap(u32, f64).init(allocator);
}

pub fn deinit() void {
    names.deinit();
    lkup.deinit();
    product_set.deinit();
    prescription_set.deinit();
    bundles.deinit();
    product_costs.deinit();
}
