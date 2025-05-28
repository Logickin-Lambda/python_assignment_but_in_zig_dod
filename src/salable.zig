const std = @import("std");

// It is actually possible to replace them with an array,
// accessing them with an numerical index,
// to get rid of the time on the index hashing.
// The method above works because it doesn't have
// any delete or middle insert for these records
// to mess up the list order.
//
// Thus, if I need to apply DOD for my actual application.
// The choice of the data structure will be based on the
// operation I need.

// Here are all the required tables and maps for the Customer database
pub var names: std.AutoHashMap(u32, []const u8) = undefined;
pub var lkup: std.StringHashMap(u32) = undefined;

pub var product_set: std.AutoHashMap(u32, u32) = undefined;
pub var prescription_set: std.AutoHashMap(u32, u32) = undefined;

pub var bundles: std.AutoHashMap(u32, std.ArrayList(u32)) = undefined;
pub var product_costs: std.AutoHashMap(u32, f64) = undefined;

pub fn init(allocator: std.mem.Allocator) void {
    names = std.AutoHashMap(u32, []const u8).init(allocator);
    lkup = std.StringHashMap(u32).init(allocator);
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
    product_costs.deinit();

    var bundles_iter = bundles.iterator();

    while (bundles_iter.next()) |bundle| {
        bundle.value_ptr.deinit();
    }

    bundles.deinit();
}

pub fn load_data(allocator: std.mem.Allocator) !void {
    // names
    try names.put(1, "vitaminC");
    try names.put(2, "vitaminE");
    try names.put(3, "vitaminD");
    try names.put(4, "coldTablet");
    try names.put(5, "vaccine");
    try names.put(6, "fragrance");
    try names.put(7, "covidTablet");
    try names.put(8, "multivitamin");
    try names.put(9, "tablet");
    try names.put(10, "beaty");

    // lookup for ids
    try lkup.put("vitaminC", 1);
    try lkup.put("vitaminE", 2);
    try lkup.put("vitaminD", 3);
    try lkup.put("coldTablet", 4);
    try lkup.put("vaccine", 5);
    try lkup.put("fragrance", 6);
    try lkup.put("covidTablet", 7);
    try lkup.put("multivitamin", 8);
    try lkup.put("tablet", 9);
    try lkup.put("beaty", 10);

    // product and prescription set
    // any item appeared in this set are products;
    // otherwise bundles
    try product_set.put(1, 0);
    try product_set.put(2, 0);
    try product_set.put(3, 0);
    try product_set.put(4, 0);
    try product_set.put(5, 0);
    try product_set.put(6, 0);
    try product_set.put(7, 0);

    try prescription_set.put(5, 0);
    try prescription_set.put(7, 0);

    // define the product costs
    try product_costs.put(1, 12);
    try product_costs.put(2, 14.5);
    try product_costs.put(3, 15.2);
    try product_costs.put(4, 6.4);
    try product_costs.put(5, 32.6);
    try product_costs.put(6, 20.5);
    try product_costs.put(7, 20.5);

    // define the bundles
    var bundle1 = std.ArrayList(u32).init(allocator);
    try bundle1.append(1);
    try bundle1.append(2);
    try bundle1.append(3);

    var bundle2 = std.ArrayList(u32).init(allocator);
    try bundle2.append(4);
    try bundle2.append(7);

    var bundle3 = std.ArrayList(u32).init(allocator);
    try bundle3.append(1);
    try bundle3.append(2);
    try bundle3.append(3);
    try bundle3.append(6);

    try bundles.put(8, bundle1);
    try bundles.put(9, bundle2);
    try bundles.put(10, bundle3);
}
