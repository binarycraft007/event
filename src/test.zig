const std = @import("std");
const builtin = @import("builtin");
const c = @cImport({
    @cInclude("event2/event.h");
    @cInclude("event2/http.h");
    @cInclude("event2/buffer.h");
    @cInclude("event2/util.h");
    @cInclude("event2/thread.h");
});

var content: [30]u8 = undefined;

test {
    const cb = struct {
        pub fn http_basic_cb(req: ?*c.evhttp_request, arg: ?*anyopaque) callconv(.C) void {
            _ = arg;
            const evb = c.evbuffer_new();
            _ = c.evbuffer_add(evb, &content, content.len);
            // allow sending of an empty reply
            c.evhttp_send_reply(req, c.HTTP_OK, "Everything is fine", evb);
            c.evbuffer_free(evb);
        }

        pub fn http_ref_cb(req: ?*c.evhttp_request, arg: ?*anyopaque) callconv(.C) void {
            _ = arg;
            const evb = c.evbuffer_new();
            _ = c.evbuffer_add_reference(evb, &content, content.len, null, null);
            // allow sending of an empty reply */
            c.evhttp_send_reply(req, c.HTTP_OK, "Everything is fine", evb);
            c.evbuffer_free(evb);
        }
    };

    if (builtin.os.tag == .windows) {
        _ = try std.os.windows.WSAStartup(2, 2);
    }
    defer {
        if (builtin.os.tag == .windows) {
            std.os.windows.WSACleanup() catch unreachable;
        }
    }

    const cfg = c.event_config_new();
    if (builtin.os.tag == .windows) {
        _ = c.event_config_avoid_method(cfg, "win32");
    }
    const base = c.event_base_new_with_config(cfg) orelse
        return error.EventBaseNew;
    const http = c.evhttp_new(base);
    _ = c.evhttp_set_cb(http, "/ind", &cb.http_basic_cb, null);
    _ = c.evhttp_set_cb(http, "/ref", &cb.http_ref_cb, null);
    _ = c.evhttp_bind_socket(http, "0.0.0.0", 8080);
    _ = c.event_base_dispatch(base);
}
