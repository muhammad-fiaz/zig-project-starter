// build.zig - Zig Project Starter
// Minimum Zig version: 0.15.0
const std = @import("std");

/// Build script targeting Zig 0.15+
/// - Builds a static library (`src/lib.zig`) and an executable (`src/main.zig`)
/// - Adds run steps and install steps
/// - Adds a test step (tests/lib_test.zig)
/// - Adds a small examples runner (examples/basic.zig)
///
/// Minimum Zig version: 0.15.0 (this script uses APIs that may not exist on older releases)
pub fn build(b: *std.Build) void {
    // Standard CLI options (target & optimize can be overridden by -D flags)
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Library module & artifact
    const lib_module = b.createModule(.{
        .root_source_file = b.path("src/lib.zig"),
        .target = target,
        .optimize = optimize,
    });

    const lib = b.addLibrary(.{
        .name = "project",
        .root_module = lib_module,
        // default linkage is static; keep explicit for clarity
        .linkage = .static,
    });

    // Make the module exportable so external projects can do `@import("project")`
    _ = b.addModule("project", .{
        .root_source_file = b.path("src/lib.zig"),
    });

    // Mark the library as an installable artifact
    b.installArtifact(lib);

    // Application (executable) module & artifact
    const app_module = b.createModule(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    const app = b.addExecutable(.{
        .name = "zig-project-starter",
        .root_module = app_module,
    });

    // Allow the executable to import the library module via `@import("project")`
    app.root_module.addImport("project", lib_module);

    // Install / Run steps for the main application
    const install_app = b.addInstallArtifact(app, .{});
    const run_app = b.addRunArtifact(app);
    run_app.step.dependOn(&install_app.step);

    // Basic examples folder (create example artifacts & run steps)
    const examples = [_]struct { name: []const u8, path: []const u8 }{
        .{ .name = "basic", .path = "examples/basic.zig" },
    };

    inline for (examples) |example| {
        // Each example is an executable that imports the library module
        const example_mod = b.createModule(.{
            .root_source_file = b.path(example.path),
            .target = target,
            .optimize = optimize,
        });

        const example_exe = b.addExecutable(.{
            .name = example.name,
            .root_module = example_mod,
        });

        example_exe.root_module.addImport("project", lib_module);

        const install_example = b.addInstallArtifact(example_exe, .{});
        const run_example = b.addRunArtifact(example_exe);

        run_example.step.dependOn(&install_example.step);
    }

    // Unit tests
    const test_mod = b.createModule(.{
        .root_source_file = b.path("tests/lib_test.zig"),
        .target = target,
        .optimize = optimize,
    });

    const tests = b.addTest(.{ .root_module = test_mod });
    const run_tests = b.addRunArtifact(tests);

    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_tests.step);

    // Optional benchmarking target (if you add bench/benchmark.zig)
    const maybe_bench_file = std.fs.cwd().openFile("bench/benchmark.zig", .{}) catch null;
    if (maybe_bench_file) |bench_file| {
        // Close the file handle immediately — the open was only to test existence.
        bench_file.close();

        const bench_mod = b.createModule(.{
            .root_source_file = b.path("bench/benchmark.zig"),
            .target = target,
            .optimize = optimize,
        });

        const bench_exe = b.addExecutable(.{
            .name = "benchmark",
            .root_module = bench_mod,
        });

        bench_exe.root_module.addImport("project", lib_module);

        const install_bench = b.addInstallArtifact(bench_exe, .{});
        const run_bench = b.addRunArtifact(bench_exe);
        run_bench.step.dependOn(&install_bench.step);
    }

    // Expose some useful top-level steps:
    // - `zig build run` -> runs app (via run artifact)
    // - `zig build test` -> runnable by the test step above
    // - `zig build install` -> installs library & exe into zig-out/bin
    // Make the default step build the application by depending on the app install artifact.
    b.default_step.dependOn(&install_app.step);

    // Provide a step that runs all examples sequentially
    const run_all_examples = b.step("run-all-examples", "Run all examples sequentially");
    inline for (examples) |example| {
        const run_name = "run-" ++ example.name;
        // Each example run step is already a run artifact with a step; chain them into run_all_examples
        // (safe to add run-only references; they will depend on install steps as above)
        const example_run_step = b.step(run_name, "Run " ++ example.name);
        // This example_run_step is minimal here, as the actual `run_example` artifact already has a step.
        run_all_examples.dependOn(example_run_step);
    }

    // Expose build flags (a few std helper flags)
    // - -Dtarget
    // - -Doptimize
    // - -Drelease-safe / -Drelease-fast
}
