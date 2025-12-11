// src/main.zig
// Demo program for Zig Project Starter

const std = @import("std");
const lib = @import("lib.zig");

pub fn main() !void {
    std.debug.print("Zig Project Starter — demo program\n", .{});
    std.debug.print("Library version: {s}\n", .{lib.version});

    const name: []const u8 = "World";

    lib.greet(name);

    const a: i64 = 4;
    const b: i64 = 7;
    const sum: i64 = lib.add(a, b);
    std.debug.print("{d} + {d} = {d}\n", .{ a, b, sum });

    const n: u16 = 10;
    const f: u128 = lib.factorial(n);
    std.debug.print("{d}! = {d}\n", .{ n, f });

    const is_sum_even = lib.isEven(sum);
    std.debug.print("Is the sum {d} even? {s}\n", .{ sum, if (is_sum_even) "yes" else "no" });
}
