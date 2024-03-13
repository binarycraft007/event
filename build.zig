const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const libevent_dep = b.dependency("libevent", .{});
    const t = target.result;
    const lib = b.addStaticLibrary(.{
        .name = "event",
        .link_libc = true,
        .root_source_file = .{ .path = "src/compat.zig" },
        .target = target,
        .optimize = optimize,
    });
    lib.want_lto = t.os.tag != .macos;
    const event_config_h = b.addConfigHeader(.{
        .style = .{ .cmake = libevent_dep.path("event-config.h.cmake") },
        .include_path = "event2/event-config.h",
    }, .{
        .EVENT_NUMERIC_VERSION = 0x02020100,
        .EVENT_PACKAGE_VERSION = "2.2.1",
        .EVENT_VERSION_MAJOR = 2,
        .EVENT_VERSION_MINOR = 2,
        .EVENT_VERSION_PATCH = 1,
        .EVENT_VERSION = "2.2.1-alpha-dev",
        .EVENT__PACKAGE = "libevent",
        .EVENT__PACKAGE_BUGREPORT = "",
        .EVENT__PACKAGE_NAME = "",
        .EVENT__PACKAGE_STRING = "",
        .EVENT__PACKAGE_TARNAME = "",
        .EVENT__HAVE_WEPOLL = @intFromBool(t.os.tag == .windows),
        .EVENT__HAVE_ACCEPT4 = 1,
        .EVENT__HAVE_ARC4RANDOM = @intFromBool(t.os.tag == .macos),
        .EVENT__HAVE_ARC4RANDOM_BUF = @intFromBool(t.os.tag == .macos),
        .EVENT__HAVE_ARC4RANDOM_ADDRANDOM = @intFromBool(t.os.tag == .macos),
        .EVENT__DNS_USE_CPU_CLOCK_FOR_ID = 1,
        .EVENT__HAVE_ARPA_INET_H = @intFromBool(t.os.tag != .windows),
        .EVENT__HAVE_CLOCK_GETTIME = 1,
        .EVENT__HAVE_DECL_CTL_KERN = 1,
        .EVENT__HAVE_DECL_KERN_ARND = 1,
        .EVENT__HAVE_GETRANDOM = @intFromBool(t.os.tag == .linux),
        .EVENT__HAVE_NETDB_H = @intFromBool(t.os.tag != .windows),
        .EVENT__HAVE_FD_MASK = 1,
        .EVENT__HAVE_TAILQFOREACH = 1,
        .EVENT__HAVE_DLFCN_H = 1,
        .EVENT__HAVE_EPOLL = @intFromBool(t.os.tag == .linux),
        .EVENT__HAVE_EPOLL_CREATE1 = @intFromBool(t.os.tag == .linux),
        .EVENT__HAVE_EPOLL_CTL = @intFromBool(t.os.tag != .macos),
        .EVENT__HAVE_EVENTFD = @intFromBool(t.os.tag == .linux),
        .EVENT__HAVE_FCNTL = @intFromBool(t.os.tag != .windows),
        .EVENT__HAVE_FCNTL_H = 1,
        .EVENT__HAVE_GETADDRINFO = @intFromBool(t.os.tag != .windows),
        .EVENT__HAVE_GETEGID = @intFromBool(t.os.tag != .windows),
        .EVENT__HAVE_GETEUID = @intFromBool(t.os.tag != .windows),
        .EVENT__HAVE_GETHOSTBYNAME_R = @intFromBool(t.os.tag != .windows),
        .EVENT__HAVE_GETHOSTBYNAME_R_6_ARG = @intFromBool(t.os.tag != .windows),
        .EVENT__HAVE_GETIFADDRS = @intFromBool(t.os.tag != .windows),
        .EVENT__HAVE_GETNAMEINFO = 1,
        .EVENT__HAVE_GETPROTOBYNUMBER = 1,
        .EVENT__HAVE_GETSERVBYNAME = 1,
        .EVENT__HAVE_GETTIMEOFDAY = 1,
        .EVENT__HAVE_IFADDRS_H = @intFromBool(t.os.tag != .windows),
        .EVENT__HAVE_INET_NTOP = 1,
        .EVENT__HAVE_INET_PTON = 1,
        .EVENT__HAVE_INTTYPES_H = 1,
        .EVENT__HAVE_KQUEUE = @intFromBool(t.os.tag == .macos),
        .EVENT__HAVE_MACH_ABSOLUTE_TIME = @intFromBool(t.os.tag == .macos),
        .EVENT__HAVE_MACH_MACH_TIME_H = @intFromBool(t.os.tag == .macos),
        .EVENT__HAVE_MACH_MACH_H = @intFromBool(t.os.tag == .macos),
        .EVENT__HAVE_MEMORY_H = 1,
        .EVENT__HAVE_MMAP = @intFromBool(t.os.tag != .windows),
        .EVENT__HAVE_NANOSLEEP = 1,
        .EVENT__HAVE_USLEEP = 1,
        .EVENT__HAVE_NETINET_IN_H = @intFromBool(t.os.tag != .windows),
        .EVENT__HAVE_NETINET_TCP_H = @intFromBool(t.os.tag != .windows),
        .EVENT__HAVE_SYS_UN_H = @intFromBool(t.os.tag != .windows),
        .EVENT__HAVE_PIPE = @intFromBool(t.os.tag != .windows),
        .EVENT__HAVE_PIPE2 = @intFromBool(t.os.tag == .linux),
        //.EVENT__HAVE_POLL = 1,
        //.EVENT__HAVE_POLL_H = 1,
        .EVENT__HAVE_PTHREADS = @intFromBool(t.os.tag != .windows),
        .EVENT__HAVE_PTHREAD_MUTEXATTR_SETPROTOCOL = @intFromBool(t.os.tag != .windows),
        .EVENT__HAVE_PUTENV = 1,
        .EVENT__HAVE_SA_FAMILY_T = 1,
        //.EVENT__HAVE_SELECT = 1,
        .EVENT__HAVE_SETENV = 1,
        .EVENT__HAVE_WORKING_KQUEUE = @intFromBool(t.os.tag == .macos),
        .EVENT__HAVE_SETFD = 1,
        .EVENT__HAVE_SETRLIMIT = @intFromBool(t.os.tag != .windows),
        .EVENT__HAVE_SENDFILE = 1,
        .EVENT__HAVE_SIGACTION = @intFromBool(t.os.tag != .windows),
        .EVENT__HAVE_SIGNAL = 1,
        .EVENT__HAVE_STRSIGNAL = @intFromBool(t.os.tag != .windows),
        .EVENT__HAVE_STDARG_H = 1,
        .EVENT__HAVE_STDDEF_H = 1,
        .EVENT__HAVE_STDINT_H = 1,
        .EVENT__HAVE_STDLIB_H = 1,
        .EVENT__HAVE_STRING_H = 1,
        .EVENT__HAVE_STRSEP = @intFromBool(t.os.tag != .windows),
        .EVENT__HAVE_STRTOK_R = 1,
        .EVENT__HAVE_STRTOLL = 1,
        .EVENT__HAVE_STRUCT_ADDRINFO = 1,
        .EVENT__HAVE_STRUCT_IN6_ADDR = 1,
        .EVENT__HAVE_STRUCT_IN6_ADDR_S6_ADDR16 = 1,
        .EVENT__HAVE_STRUCT_IN6_ADDR_S6_ADDR32 = 1,
        .EVENT__HAVE_STRUCT_SOCKADDR_IN6 = 1,
        .EVENT__HAVE_STRUCT_SOCKADDR_UN = @intFromBool(t.os.tag != .windows),
        .EVENT__HAVE_STRUCT_SOCKADDR_STORAGE = 1,
        .EVENT__HAVE_STRUCT_SOCKADDR_STORAGE_SS_FAMILY = 1,
        .EVENT__HAVE_STRUCT_LINGER = 1,
        .EVENT__HAVE_SYS_EPOLL_H = @intFromBool(t.os.tag == .linux),
        .EVENT__HAVE_SYS_EVENTFD_H = @intFromBool(t.os.tag == .linux),
        .EVENT__HAVE_SYS_IOCTL_H = @intFromBool(t.os.tag != .windows),
        .EVENT__HAVE_SYS_MMAN_H = @intFromBool(t.os.tag != .windows),
        .EVENT__HAVE_SYS_PARAM_H = 1,
        .EVENT__HAVE_SYS_QUEUE_H = 1,
        .EVENT__HAVE_SYS_RESOURCE_H = @intFromBool(t.os.tag != .windows),
        //.EVENT__HAVE_SYS_SELECT_H = 1,
        .EVENT__HAVE_SYS_SENDFILE_H = @intFromBool(t.os.tag == .linux),
        .EVENT__HAVE_SYS_SOCKET_H = @intFromBool(t.os.tag != .windows),
        .EVENT__HAVE_SYS_STAT_H = 1,
        .EVENT__HAVE_SYS_RANDOM_H = 1,
        .EVENT__HAVE_SYS_TIMERFD_H = @intFromBool(t.os.tag == .linux),
        .EVENT__HAVE_SYS_SIGNALFD_H = @intFromBool(t.os.tag == .linux),
        .EVENT__HAVE_SYS_TIME_H = 1,
        .EVENT__HAVE_SYS_TYPES_H = 1,
        .EVENT__HAVE_SYS_UIO_H = @intFromBool(t.os.tag != .windows),
        .EVENT__HAVE_SYS_WAIT_H = @intFromBool(t.os.tag != .windows),
        .EVENT__HAVE_ERRNO_H = 1,
        .EVENT__HAVE_TIMERADD = @intFromBool(t.os.tag != .windows),
        .EVENT__HAVE_TIMERCLEAR = 1,
        .EVENT__HAVE_TIMERCMP = 1,
        .EVENT__HAVE_TIMERFD_CREATE = @intFromBool(t.os.tag == .linux),
        .EVENT__HAVE_TIMERISSET = 1,
        .EVENT__HAVE_UINT8_T = 1,
        .EVENT__HAVE_UINT16_T = 1,
        .EVENT__HAVE_UINT32_T = 1,
        .EVENT__HAVE_UINT64_T = 1,
        .EVENT__HAVE_UINTPTR_T = 1,
        .EVENT__HAVE_UMASK = 1,
        .EVENT__HAVE_UNISTD_H = 1,
        .EVENT__HAVE_UNSETENV = 1,
        .EVENT__SIZEOF_PTHREAD_T = t.ptrBitWidth() / 8,
        .EVENT__SIZEOF_INT = t.c_type_byte_size(.int),
        .EVENT__SIZEOF_LONG = t.c_type_byte_size(.long),
        .EVENT__SIZEOF_LONG_LONG = t.c_type_byte_size(.longlong),
        .EVENT__SIZEOF_OFF_T = 8,
        .EVENT__SIZEOF_SSIZE_T = t.ptrBitWidth() / 8,
        .EVENT__SIZEOF_SHORT = t.c_type_byte_size(.short),
        .EVENT__SIZEOF_SIZE_T = t.ptrBitWidth() / 8,
        .EVENT__SIZEOF_SOCKLEN_T = 4,
        .EVENT__SIZEOF_VOID_P = t.ptrBitWidth() / 8,
        .EVENT__SIZEOF_TIME_T = 8,
        .EVENT__inline = "inline",
        .EVENT__HAVE___func__ = 1,
        .EVENT__HAVE___FUNCTION__ = 1,
        .EVENT__size_t = "size_t",
        .EVENT__socklen_t = "socklen_t",
        .EVENT__ssize_t = "ssize_t",
    });
    const evconfig_private_h = b.addConfigHeader(.{
        .style = .{ .cmake = libevent_dep.path("evconfig-private.h.cmake") },
        .include_path = "evconfig-private.h",
    }, .{
        ._GNU_SOURCE = @intFromBool(t.abi.isGnu()),
        .WIN32_LEAN_AND_MEAN = @intFromBool(t.os.tag == .windows),
    });
    lib.addConfigHeader(event_config_h);
    lib.addConfigHeader(evconfig_private_h);
    lib.installConfigHeader(event_config_h, .{});
    lib.installConfigHeader(evconfig_private_h, .{});
    lib.installHeadersDirectory(libevent_dep.path("compat").getPath(b), "");
    lib.installHeadersDirectory(libevent_dep.path("include").getPath(b), "");
    if (t.os.tag == .windows) {
        lib.linkSystemLibrary("ws2_32");
        lib.linkSystemLibrary("shell32");
        lib.linkSystemLibrary("advapi32");
        lib.linkSystemLibrary("bcrypt");
        lib.linkSystemLibrary("iphlpapi");
        lib.addIncludePath(libevent_dep.path("WIN32-Code"));
    } else {
        inline for (unix_src_files) |src_file| {
            lib.addCSourceFile(.{
                .file = libevent_dep.path(src_file),
                .flags = &cflags,
            });
        }
        lib.linkSystemLibrary("pthread");
    }
    inline for (general_src_files) |src_file| {
        lib.addCSourceFile(.{
            .file = libevent_dep.path(src_file),
            .flags = &cflags,
        });
    }
    inline for (extra_src_files) |src_file| {
        lib.addCSourceFile(.{
            .file = libevent_dep.path(src_file),
            .flags = &cflags,
        });
    }
    switch (t.os.tag) {
        .linux => {
            inline for (linux_src_files) |src_file| {
                lib.addCSourceFile(.{
                    .file = libevent_dep.path(src_file),
                    .flags = &cflags,
                });
            }
        },
        .windows => {
            inline for (windows_src_files) |src_file| {
                lib.addCSourceFile(.{
                    .file = libevent_dep.path(src_file),
                    .flags = &cflags,
                });
            }
        },
        .macos => {
            inline for (macos_src_files) |src_file| {
                lib.addCSourceFile(.{
                    .file = libevent_dep.path(src_file),
                    .flags = &cflags,
                });
            }
        },
        else => {},
    }
    lib.addIncludePath(libevent_dep.path("."));
    lib.addIncludePath(libevent_dep.path("compat"));
    lib.addIncludePath(libevent_dep.path("include"));
    b.installArtifact(lib);

    const main_tests = b.addTest(.{
        .root_source_file = .{ .path = "src/test.zig" },
        .target = target,
        .optimize = optimize,
    });
    main_tests.linkLibrary(lib);

    const run_main_tests = b.addRunArtifact(main_tests);

    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&run_main_tests.step);
}

const cflags = [_][]const u8{
    "-Wall",
    "-Wextra",
    "-Wno-unused-parameter",
    "-Wstrict-aliasing",
    "-Wstrict-prototypes",
    "-Wundef",
    "-fno-strict-aliasing",
    "-Wmissing-prototypes",
    "-Winit-self",
    "-Wmissing-field-initializers",
    "-Wdeclaration-after-statement",
    "-Waddress",
    "-Woverride-init",
    "-Wwrite-strings",
    "-Wno-unused-function",
    "-Wno-pragmas",
    "-Wvla",
    "-Wno-void-pointer-to-enum-cast",
    "-Wno-int-conversion",
};

const general_src_files = [_][]const u8{
    "buffer.c",
    "bufferevent.c",
    "bufferevent_filter.c",
    "bufferevent_pair.c",
    "bufferevent_ratelim.c",
    "bufferevent_sock.c",
    "event.c",
    "evmap.c",
    "evthread.c",
    "evutil.c",
    "evutil_rand.c",
    "evutil_time.c",
    "watch.c",
    "listener.c",
    "log.c",
    "signal.c",
    "strlcpy.c",
};

const unix_src_files = [_][]const u8{
    "select.c",
    "poll.c",
    "evthread_pthread.c",
};

const linux_src_files = [_][]const u8{
    "epoll.c",
    "signalfd.c",
};

const macos_src_files = [_][]const u8{
    "kqueue.c",
};

const windows_src_files = [_][]const u8{
    "buffer_iocp.c",
    "bufferevent_async.c",
    "event_iocp.c",
    "win32select.c",
    "wepoll.c",
    "epoll.c",
    "evthread_win32.c",
};

const extra_src_files = [_][]const u8{
    "event_tagging.c",
    "http.c",
    "evdns.c",
    "ws.c",
    "evrpc.c",
};
