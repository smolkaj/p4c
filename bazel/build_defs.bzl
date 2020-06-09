"""P4 compilation rules."""

def _p4_library_impl(ctx):
    p4c = ctx.executable._p4c
    p4file = ctx.file.src
    target = ctx.attr.target
    cmd = [
        p4c.path,
        p4file.path,
        "--std",
        ctx.attr.std,
        "--target",
        (target if target else "bmv2"),
        "--arch",
        ctx.attr.arch,
        ctx.attr.extra_args,
    ]
    for dep in ctx.files._p4include + ctx.files.deps:
        cmd.append("-I" + dep.dirname)
    outputs = []

    if ctx.outputs.p4info_out:
        if target != "" and target != "bmv2":
            fail('Must use `target = "bmv2"` when specifying p4info_out.')
        cmd += ["--p4runtime-files", ctx.outputs.p4info_out.path]
        outputs.append(ctx.outputs.p4info_out)

    if ctx.outputs.target_out:
        if not target:
            fail("Cannot specify target_out without specifying target explicitly.")
        cmd += ["-o", ctx.outputs.target_out.path]
        outputs.append(ctx.outputs.target_out)

    if not outputs:
        fail("No outputs specified. Must specify p4info_out or target_out or both.")

    ctx.actions.run_shell(
        tools = [p4c],
        inputs = [p4file] + ctx.files._p4include,
        outputs = outputs,
        progress_message = "Compiling P4 program %s" % p4file.short_path,
        command = " ".join(cmd),
        use_default_shell_env = True,  # This is so p4c find cc.
    )

p4_library = rule(
    doc = "Compiles P4 program using the p4c compiler.",
    implementation = _p4_library_impl,
    attrs = {
        "src": attr.label(
            doc = "P4 source file to pass to p4c.",
            mandatory = True,
            allow_single_file = [".p4"],
        ),
        "deps": attr.label_list(
            doc = "Additional P4 dependencies (optional). Use for #include-ed files.",
            mandatory = False,
            allow_files = [".p4", ".h"],
            default = [],
        ),
        "p4info_out": attr.output(
            mandatory = False,
            doc = "The name of the p4info output file.",
        ),
        "target_out": attr.output(
            mandatory = False,
            doc = "The name of the target output file, passed to p4c via -o.",
        ),
        "target": attr.string(
            doc = "The --target argument passed to p4c (default: bmv2).",
            mandatory = False,
            default = "",  # Use "" so we can recognize implicit target.
        ),
        "arch": attr.string(
            doc = "The --arch argument passed to p4c (default: v1model).",
            mandatory = False,
            default = "v1model"
        ),
        "std": attr.string(
            doc = "The --std argument passed to p4c (default: p4-16).",
            mandatory = False,
            default = "p4-16"
        ),
        "extra_args": attr.string(
            doc = "String of additional command line arguments to pass to p4c.",
            mandatory = False,
            default = "",
        ),
        "_p4c": attr.label(
            default = Label("@com_github_p4lang_p4c//:p4c_bmv2"),
            executable = True,
            cfg = "target",
        ),
        "_p4include": attr.label(
            default = Label("@com_github_p4lang_p4c//:p4include"),
            allow_files = [".p4", ".h"],
        ),
        "_cc_toolchain": attr.label(default = Label("@bazel_tools//tools/cpp:current_cc_toolchain")),
    },
)
