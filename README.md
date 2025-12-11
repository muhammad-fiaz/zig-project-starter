# Zig Project Starter

a minimal starter template for Zig projects, including build script, source structure, and testing setup.

Requirements
- Zig >= 0.15.0

Quick start
1. Clone: `git clone https://github.com/muhammad-fiaz/zig-project-starter.git`
2. Enter: `cd zig-project-starter`
3. Build: `zig build`
4. Run: `zig build run` (if a run step is configured)
5. Test: `zig test`

Project layout
- `build.zig` — central build script
- `src/lib.zig` — library code
- `src/main.zig` — demo executable
- `tests/lib_test.zig` — unit tests
- `examples/` — small demos (optional)

Dependencies
- Fetch and save a Zig package: `zig fetch --save https://github.com/owner/zig-package.git`
- Import a fetched dependency: `@import("zig-cache/deps/github.com-owner-zig-package/src/lib.zig")`
- Or wire dependencies into `build.zig` per your workflow/version of Zig

Notes
- Run `zig fmt` to format code.
- `zig-cache` and `zig-out` are build artifacts and should be ignored by git.

License
- MIT