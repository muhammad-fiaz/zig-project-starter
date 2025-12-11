// tests/lib_test.zig
// Unit tests for the library (src/lib.zig)
//
// Run:
//   zig test
//

const std = @import("std");

// Import the library module under test using a relative path.
// This keeps tests self-contained. Using an explicit path means the test
// will work without extra build script changes.
const lib = @import("../src/lib.zig");

test "add: returns the sum of two integers" {
    // We expect a + b to be equal to their arithmetic sum.
    try std.testing.expectEqual(i64, 7, lib.add(3, 4));
    try std.testing.expectEqual(i64, -1, lib.add(-2, 1));
}

test "factorial: small values produce expected results" {
    // Test several small values to ensure correctness.
    try std.testing.expectEqual(u128, 1, lib.factorial(0));
    try std.testing.expectEqual(u128, 1, lib.factorial(1));
    try std.testing.expectEqual(u128, 120, lib.factorial(5));
    try std.testing.expectEqual(u128, 3628800, lib.factorial(10));
}

// average test removed (lib.average was removed to avoid float casting across environments)

test "isEven: behaves as expected" {
    try std.testing.expect(lib.isEven(@as(i64, 0)));
    try std.testing.expect(lib.isEven(@as(i64, 2)));
    try std.testing.expect(!lib.isEven(@as(i64, 3)));
    try std.testing.expect(!lib.isEven(@as(i64, 9999999999999)));
}

test "greet: callable and side effects do not error (smoke test)" {
    // `greet` prints a message; for unit tests we do not assert on text output,
    // we call it to ensure no runtime errors occur.
    lib.greet("Test");
    lib.greet("Zig");
}

test "version string is set and non-empty" {
    try std.testing.expect(lib.version.len > 0);
    try std.testing.expectEqual([]const u8, "0.1.0", lib.version);
}
