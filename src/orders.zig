const std = @import("std");

// order tables
const Order = struct {
    order_id: u32,
    ttl_cost: f64,
    reward: u32,
    // dd mm yyyy, hh24, mi, ss
    created_date: struct {
        dd: u8,
        mm: u8,
        yyyy: u16,
        hh24: u8,
        mi: u8,
        ss: u8,
    },
};

const OrderItems = struct {
    prod_id: u32,
    quantity: u32,
};

// This is the part I am unsure if I should do AoS or SoA because
// all function related to this dataset use all of the data,
// except that if there is by user_id search which I have use
// a hashmap to speed up the search process.
pub var records: std.AutoHashMap(u32, std.ArrayList(Order)) = undefined;
pub var items: std.AutoHashMap(u32, std.ArrayList(OrderItems)) = undefined;

pub fn init(allocator: std.mem.Allocator) void {
    records = std.AutoHashMap(u32, std.ArrayList(Order)).init(allocator);
    items = std.AutoHashMap(u32, std.ArrayList(OrderItems)).init(allocator);
}

pub fn deinit() void {
    var records_iter = records.iterator();

    while (records_iter.next()) |record| {
        record.value_ptr.deinit();
    }
    records.deinit();

    var items_iter = items.iterator();
    while (items_iter.next()) |item| {
        item.value_ptr.deinit();
    }
    items.deinit();
}

/// this part will be messy because I was lazy to covert all those
/// strings into fixed size arrays which I don't want to import
/// a string dependency for that
/// Perhaps, the next task is to learn how to parse strings
/// in zig which I don't have a good idea yet.
pub fn load_data(allocator: std.mem.Allocator) !void {
    var order_id: u32 = 1;

    // B1 history:
    var item_b1 = std.ArrayList(OrderItems).init(allocator);
    try item_b1.append(.{ .prod_id = 1, .quantity = 1 });
    try item_b1.append(.{ .prod_id = 2, .quantity = 2 });

    var order_b1 = std.ArrayList(Order).init(allocator);
    try order_b1.append(.{
        .order_id = order_id,
        .reward = 41,
        .ttl_cost = 41.0,
        .created_date = .{ .dd = 1, .mm = 4, .yyyy = 2024, .hh24 = 10, .mi = 4, .ss = 0 },
    });

    try items.put(order_id, item_b1);
    try records.put(1, order_b1);

    // B2 history:
    order_id += 1;

    var item_b2 = std.ArrayList(OrderItems).init(allocator);
    try item_b2.append(.{ .prod_id = 8, .quantity = 2 });

    var order_b2 = std.ArrayList(Order).init(allocator);
    try order_b2.append(.{
        .order_id = order_id,
        .reward = 67,
        .ttl_cost = 66.72,
        .created_date = .{ .dd = 5, .mm = 4, .yyyy = 2024, .hh24 = 14, .mi = 0, .ss = 0 },
    });

    try items.put(order_id, item_b2);
    try records.put(2, order_b2);

    // V3 history:
    order_id += 1;

    var item_v3a = std.ArrayList(OrderItems).init(allocator);
    try item_v3a.append(.{ .prod_id = 4, .quantity = 1 });

    var order_v3 = std.ArrayList(Order).init(allocator);
    try order_v3.append(.{
        .order_id = order_id,
        .reward = 36,
        .ttl_cost = 35.88,
        .created_date = .{ .dd = 6, .mm = 4, .yyyy = 2024, .hh24 = 9, .mi = 4, .ss = 0 },
    });

    try items.put(order_id, item_v3a);

    order_id += 1;

    var item_v3b = std.ArrayList(OrderItems).init(allocator);
    try item_v3b.append(.{ .prod_id = 9, .quantity = 1 });

    try order_v3.append(.{
        .order_id = order_id,
        .reward = 20,
        .ttl_cost = 19.80,
        .created_date = .{ .dd = 14, .mm = 4, .yyyy = 2024, .hh24 = 9, .mi = 10, .ss = 0 },
    });

    try items.put(order_id, item_v3b);
    try records.put(3, order_v3);

    // B5 history:
    order_id += 1;

    var item_b5 = std.ArrayList(OrderItems).init(allocator);
    try item_b5.append(.{ .prod_id = 6, .quantity = 3 });

    var order_b5 = std.ArrayList(Order).init(allocator);
    try order_b5.append(.{
        .order_id = order_id,
        .reward = 75,
        .ttl_cost = 75,
        .created_date = .{ .dd = 10, .mm = 4, .yyyy = 2024, .hh24 = 15, .mi = 20, .ss = 0 },
    });

    try items.put(order_id, item_b5);
    try records.put(5, order_b5);

    // B10 history:
    order_id += 1;

    var item_b10 = std.ArrayList(OrderItems).init(allocator);
    try item_b10.append(.{ .prod_id = 3, .quantity = 3 });

    var order_b10 = std.ArrayList(Order).init(allocator);
    try order_b10.append(.{
        .order_id = order_id,
        .reward = 46,
        .ttl_cost = 45.6,
        .created_date = .{ .dd = 15, .mm = 4, .yyyy = 2024, .hh24 = 20, .mi = 0, .ss = 0 },
    });

    try items.put(order_id, item_b10);
    try records.put(10, order_b10);
}
