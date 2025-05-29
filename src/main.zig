const std = @import("std");
const Customers = @import("customers.zig");
const Salable = @import("salable.zig");
const Order = @import("orders.zig");
const Display = @import("console_display.zig");

pub fn main() !void {
    std.debug.print("<!--Skri-a Kaark-->\n", .{});

    const page = std.heap.page_allocator;
    var arena = std.heap.ArenaAllocator.init(page);
    defer arena.deinit();

    Customers.init(arena.allocator());
    defer Customers.deinit();
    try Customers.load_data();

    Salable.init(arena.allocator());
    defer Salable.deinit();
    try Salable.load_data(arena.allocator());

    Order.init(arena.allocator());
    defer Order.deinit();
    try Order.load_data(arena.allocator());

    std.debug.print("test customer: {d}, {s}\n", .{ 1, Customers.names.get(1).? });
    std.debug.print("test product: {d}, {s}\n", .{ 9, Salable.names.get(5).? });
    std.debug.print("test order: {d}, {any}\n", .{ 10, Order.records.get(10).? });

    try Display.demoscene_slide(arena.allocator(), Display.demoscene_action.appear);
    try Display.demoscene_text_shift(arena.allocator(), Display.demoscene_action.scroll_right);
    try Display.demoscene_text_shift(arena.allocator(), Display.demoscene_action.scroll_left);
    try Display.demoscene_slide(arena.allocator(), Display.demoscene_action.disappear);
}
