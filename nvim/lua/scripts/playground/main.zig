const std = @import("std");
const testing = std.testing;

pub fn main() !void {
    std.debug.print("All your {s} are belong to us.\n", .{"codebase"});

    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    try stdout.print("Run `zig build test` to run the tests.\n", .{});

    try bw.flush(); // don't forget to flush!
}

test "my test" {
    const foo = 2 + 2;
    try testing.expectEqual(4, foo);
}

test "my other test" {
    const foo = 2 + 2;
    try testing.expectEqual(4, foo);
}
