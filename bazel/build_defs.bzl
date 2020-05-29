"""P4 compilation rules."""

load("@bazel_tools//tools/cpp:toolchain_utils.bzl", "find_cpp_toolchain")

def _generate_bmv2_config(ctx):
    """Preprocesses P4 sources and runs p4c on pre-processed P4 file."""

    # Preprocess all files and create 'p4_preprocessed_file'
    p4_preprocessed_file = ctx.actions.declare_file(
        ctx.configuration.genfiles_dir.path + ctx.label.name + ".pp.p4",
    )
    hdr_include_str = ""
    for hdr in ctx.files.hdrs:
        hdr_include_str += "-I " + hdr.dirname
    cpp_toolchain = find_cpp_toolchain(ctx)

    ctx.actions.run(
        arguments = [
            "-E",
            "-x",
            "c",
            ctx.file.src.path,
            "-I.",
            "-I",
            ctx.file._model.dirname,
            "-I",
            ctx.file._core.dirname,
            hdr_include_str,
            "-o",
            p4_preprocessed_file.path,
        ] + ctx.attr.copts,
        inputs = ([ctx.file.src] + ctx.files.hdrs + [ctx.file._model] +
                  [ctx.file._core] + ctx.files.cpp),
        outputs = [p4_preprocessed_file],
        progress_message = "Preprocessing...",
        executable = cpp_toolchain.compiler_executable,
    )

    # Run p4c on pre-processed P4_16 sources to obtain p4info.
    gen_files = [
        ctx.outputs.out_p4_info,
        ctx.outputs.out_p4_pipeline_json,
    ]

    ctx.actions.run(
        arguments = [
            "--nocpp",
            "--p4v",
            "16",
            "--p4runtime-format",
            "text",
            "--p4runtime-file",
            gen_files[0].path,
            "-o",
            gen_files[1].path,
            p4_preprocessed_file.path,
        ],
        inputs = [p4_preprocessed_file],
        outputs = [gen_files[0], gen_files[1]],
        progress_message = "Compiling P4 sources to generate bmv2 config",
        executable = ctx.executable._p4c_bmv2,
    )

    return DefaultInfo(files = depset(gen_files))

#  Compiles P4_16 source into bmv2 target JSON configuration and p4info.
p4_bmv2_config = rule(
    implementation = _generate_bmv2_config,
    fragments = ["cpp"],
    attrs = {
        "src": attr.label(mandatory = True, allow_single_file = True),
        "hdrs": attr.label_list(
            allow_files = True,
            mandatory = True,
        ),
        "out_p4_info": attr.output(mandatory = True),
        "out_p4_pipeline_json": attr.output(mandatory = False),
        "copts": attr.string_list(),
        "_model": attr.label(
            allow_single_file = True,
            mandatory = False,
            default = Label("@p4lang_p4c//:p4include/v1model.p4"),
        ),
        "_core": attr.label(
            allow_single_file = True,
            mandatory = False,
            default = Label("@p4lang_p4c//:p4include/core.p4"),
        ),
        "_p4c_bmv2": attr.label(
            cfg = "target",
            executable = True,
            default = Label("@p4lang_p4c//:p4c_bmv2"),
        ),
        "cpp": attr.label_list(default = [Label("@bazel_tools//tools/cpp:toolchain")]),
        "_cc_toolchain": attr.label(default = Label("@bazel_tools//tools/cpp:current_cc_toolchain")),
    },
    output_to_genfiles = True,
)
