const std = @import("std");

// order tables
const Order = struct {
    order_id: u32,
    ttl_cost: f64,
    reward: u32,
    // dd mm yyyy, hh24, mi, ss
    created_date: struct { u8, u8, u16, u8, u8, u8 },
};

const OrderItems = struct {
    prod_id: u32,
    quantity: u32,
};

var records: std.AutoHashMap(u32, std.ArrayList(Order)) = undefined;
var items: std.AutoHashMap(u32, std.ArrayList(OrderItems)) = undefined;

pub fn init(allocator: std.mem.Allocator) void {
    records = std.AutoHashMap(u32, std.ArrayList(Order)).init(allocator);
    items = std.AutoHashMap(u32, std.ArrayList(items)).init(allocator);
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
