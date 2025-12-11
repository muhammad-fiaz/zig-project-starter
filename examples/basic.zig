// examples/basic.zig
// Simple example that demonstrates using the library from `src/lib.zig`.

const std = @import("std");
const lib = @import("../src/lib.zig");

pub fn main() !void {
    std.debug.print("examples/basic: demo\n", .{});

    // Use library helper:
    lib.greet("examples/basic");

    // Simple arithmetic example:
    const s: i64 = lib.add(13, 29);
    std.debug.print("13 + 29 = {d}\n", .{s});

    // Factorial (pure computation example)
    const f: u128 = lib.factorial(10);
    std.debug.print("10! = {u}\n", .{f});

    // Small check using isEven
    const sum_is_even = lib.isEven(s);
    std.debug.print("Is 13 + 29 even? {s}\n", .{if (sum_is_even) "yes" else "no"});
}
