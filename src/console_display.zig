/// console_display.zig is purely aimed for processing string and character without using
/// strings library, to explore what is the better practice on string handling.
const std = @import("std");

pub const demoscene_action = enum {
    appear,
    disappear,
    scroll_left,
    scroll_right,
};

/// multiple line string is really nice because I don't need to worry about
/// the escape characters and now I can just clearly see what my message really is
const moving_text =
    \\       ________  _____ ______   ________                      
    \\      |\   __  \|\   _ \  _   \|\   ____\      ____           
    \\      \ \  \|\  \ \  \\\__\ \  \ \  \___|_  __|\   \____      
    \\       \ \   ____\ \  \\|__| \  \ \_____  \|\____    ___\     
    \\        \ \  \___|\ \  \    \ \  \|____|\  \|___|\___\__|     
    \\         \ \__\    \ \__\    \ \__\____\_\  \   \|___|        
    \\          \|__|     \|__|     \|__|\_________\                
    \\                                  \|_________|                
;

const separator = "==================================================================\n";
const title = "|| Pharmacy Management System + || Unit no. xxxxx || Ver: 2.0.0 ||\n";

// input: []const u8 is unnecessary in this example,
// but I want to reminds me of how to handle *const [x:0]u8 string into a slices
pub fn generate_logo(allocator: std.mem.Allocator, input: []const u8, proportion: usize) !std.ArrayList([]const u8) {
    var text_iter = std.mem.splitAny(u8, input, "\n");

    // std.debug.print("\x1B[2J\x1B[H", .{}); // "clear" the screen
    // std.debug.print("{s}", .{separator});

    var text_array = std.ArrayList([]const u8).init(allocator);
    try text_array.append(separator[0..proportion]);

    while (text_iter.next()) |string| {
        const formatted = try std.fmt.allocPrint(allocator, "||{s}||\n", .{string});
        // defer allocator.destroy(&formatted);
        // std.debug.print("{s}", .{formatted});
        try text_array.append(formatted[0..proportion]);
    }
    // std.debug.print("{s}", .{separator});
    try text_array.append(separator[0..proportion]);
    try text_array.append(title[0..proportion]);
    try text_array.append(separator[0..proportion]);

    return text_array;
}

pub fn demoscene_slide(allocator: std.mem.Allocator, action: demoscene_action) !void {

    // instead of doing two functions, the logic behind showing and disappear are identical,
    // but traveling different directions

    for (0..separator.len) |i| {
        var proportion: usize = undefined;
        if (action == demoscene_action.appear) {
            proportion = i;
        } else {
            proportion = separator.len - 1 - i;
        }

        std.debug.print("\x1B[2J\x1B[H", .{}); // "clear" the screen
        var text_list = try generate_logo(allocator, moving_text, proportion);
        defer text_list.deinit();

        for (text_list.items) |text| {
            std.debug.print("{s}\n", .{text});
            allocator.destroy(&text);
        }

        std.time.sleep(20 * 1000 * 1000);
    }
}

pub fn demoscene_text_shift(allocator: std.mem.Allocator, action: demoscene_action) !void {
    var text_iter = std.mem.splitAny(u8, moving_text, "\n");
    var text_list = std.ArrayList([]u8).init(allocator);
    defer text_list.deinit();

    while (text_iter.next()) |text| {

        // because text from the iterator is always immutable
        const text_mut = try allocator.dupe(u8, text);
        try text_list.append(text_mut);
    }

    const text_row_len = text_list.items[0].len;

    // this determine the direction
    var direction: usize = undefined;
    if (action == demoscene_action.scroll_left) {
        direction = 1;
    } else {
        direction = text_row_len - 1;
    }

    for (0..text_row_len) |_| {
        std.debug.print("\x1B[2J\x1B[H", .{}); // "clear" the screen

        for (0..text_list.items.len) |j| {
            std.mem.rotate(u8, text_list.items[j], direction);
        }

        var joined_string = try std.mem.join(allocator, "\n", text_list.items);
        defer allocator.destroy(&joined_string);

        var final_text_list = try generate_logo(allocator, joined_string, separator.len);
        defer final_text_list.deinit();

        for (final_text_list.items) |text| {
            std.debug.print("{s}", .{text});
            allocator.destroy(&text);
        }

        std.time.sleep(20 * 1000 * 1000);
    }
}

test "multi line text" {
    for (moving_text.*) |char| {
        std.debug.print("{c}", .{char});
    }
}

test "text split" {
    var text_iter = std.mem.splitAny(u8, moving_text, "\n");

    while (text_iter.next()) |text| {
        std.debug.print("Line: {s}\n", .{text});
    }
}

test "command Line test" {
    std.debug.print("something something \n", .{});
    std.debug.print("something something \n", .{});
    std.debug.print("something something \n", .{});
    std.debug.print("something something \n", .{});

    // can I clear the terminal?
    // I have no idea how to execute a command for now,
    // this is the next best thing for now although
    // it just hides text rather than actually clears
    // it like using cls
    std.debug.print("\x1B[2J\x1B[H", .{});

    std.debug.print("something something \n", .{});
    std.debug.print("something something \n", .{});
    std.debug.print("something something \n", .{});
    std.debug.print("something something \n", .{});
}

test "generate_header" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const result = try generate_logo(arena.allocator(), moving_text, 2);

    for (result.items, 0..) |item, i| {
        std.debug.print("{s}\n", .{item});
        if (i == 0 or i == result.items.len - 1 or i == result.items.len - 3) {
            try std.testing.expect(std.mem.eql(u8, item, "=="));
        } else {
            try std.testing.expect(std.mem.eql(u8, item, "||"));
        }
    }

    try demoscene_slide(arena.allocator(), demoscene_action.appear);
}

test "cyclic shift" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    try demoscene_text_shift(arena.allocator(), demoscene_action.scroll_right);
}
