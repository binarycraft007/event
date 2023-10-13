const std = @import("std");
const builtin = @import("builtin");
const missing = @import("missing.zig");

const in6addr_any = [_]u8{0} ** 16;
const GAI_STRERROR_BUFFER_SIZE = 1024;

comptime {
    if (builtin.os.tag == .windows) {
        @export(missing.in6addr_any, .{ .name = "in6addr_any" });
        @export(missing.gai_strerrorA, .{ .name = "gai_strerrorA" });
        if (builtin.cpu.arch == .aarch64) {
            @export(missing._getpid, .{ .name = "_getpid" });
        }
    }
}

export fn builtin_SHA1(hash_out: [*c]u8, str: [*c]const u8, len: c_int) void {
    var sha1 = std.crypto.hash.Sha1.init(.{});
    sha1.update(str[0..@intCast(len)]);
    sha1.final(@ptrCast(hash_out));
}

test {
    _ = @import("missing.zig");
}
