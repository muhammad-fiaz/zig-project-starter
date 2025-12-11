// src/lib.zig - minimal library

const std = @import("std");

/// Library version.
pub const version: []const u8 = "0.1.0";

/// Greet name.
pub fn greet(name: []const u8) void {
    std.debug.print("Hello, {s}!\n", .{name});
}

/// Add two integers.
pub fn add(a: i64, b: i64) i64 {
    return a + b;
}

/// Factorial (n!).
pub fn factorial(n: u16) u128 {
    var acc: u128 = 1;

    var i: u128 = 2;
    const limit = @as(u128, n);
    while (i <= limit) : (i += 1) {
        acc *= i;
    }
    return acc;
}


/// True if n is even.
pub fn isEven(n: i64) bool {
    return ((n & 1) == 0);
}
