const std = @import("std");
const builtin = @import("builtin");
const testing = std.testing;
const windows = std.os.windows;
const WCHAR = windows.WCHAR;

const in6addr_any = [_]u8{0} ** 16;
const GAI_STRERROR_BUFFER_SIZE = 1024;

inline fn MAKELANGID(p: c_ushort, s: c_ushort) windows.LANGID {
    return (s << 10) | p;
}

pub fn gai_strerrorW(ecode: c_int) callconv(.C) [*c]WCHAR {
    const static = struct {
        var buf: [GAI_STRERROR_BUFFER_SIZE + 1]WCHAR = [_]WCHAR{0} ** (GAI_STRERROR_BUFFER_SIZE + 1);
    };
    var len = windows.kernel32.FormatMessageW(
        windows.FORMAT_MESSAGE_FROM_SYSTEM |
            windows.FORMAT_MESSAGE_IGNORE_INSERTS |
            windows.FORMAT_MESSAGE_MAX_WIDTH_MASK,
        null,
        @enumFromInt(ecode),
        MAKELANGID(windows.LANG.NEUTRAL, windows.SUBLANG.DEFAULT),
        @ptrCast(&static.buf),
        GAI_STRERROR_BUFFER_SIZE,
        null,
    );
    std.debug.assert(len < GAI_STRERROR_BUFFER_SIZE);
    return @ptrCast(&static.buf);
}

pub fn gai_strerrorA(ecode: c_int) callconv(.C) [*c]u8 {
    const static = struct {
        var buf: [GAI_STRERROR_BUFFER_SIZE + 1]u8 = [_]u8{0} ** (GAI_STRERROR_BUFFER_SIZE + 1);
    };
    var len = std.unicode.utf16leToUtf8(&static.buf, std.mem.span(gai_strerrorW(ecode))) catch
        return null;
    std.debug.assert(len < GAI_STRERROR_BUFFER_SIZE);
    return @ptrCast(&static.buf);
}

pub fn _getpid() callconv(.C) c_int {
    return @intCast(windows.kernel32.GetCurrentProcessId());
}

test "gai_strerrorA" {
    if (builtin.os.tag == .windows) {
        try testing.expectEqualSlices(u8, "Incorrect function. ", std.mem.span(gai_strerrorA(1)));
    }
}
