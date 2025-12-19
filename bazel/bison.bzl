"""Build rule for generating C or C++ sources with Bison."""

def _genyacc_impl(ctx):
    """Implementation for genyacc rule."""

    bison_toolchain = ctx.toolchains["@rules_bison//bison:toolchain_type"]
    bison_info = bison_toolchain.bison_toolchain

    # Argument list
    args = ctx.actions.args()
    args.add("--defines=%s" % ctx.outputs.header_out.path)
    args.add("--output-file=%s" % ctx.outputs.source_out.path)
    if ctx.attr.prefix:
        args.add("--name-prefix=%s" % ctx.attr.prefix)

    for opt in ctx.attr.extra_options:
        args.add(ctx.expand_location(opt))

    args.add(ctx.file.src.path)

    # Output files
    outputs = ctx.outputs.extra_outs + [
        ctx.outputs.header_out,
        ctx.outputs.source_out,
    ]

    ctx.actions.run(
        executable = bison_info.bison_tool,
        arguments = [args],
        inputs = ctx.files.src,
        outputs = outputs,
        mnemonic = "Yacc",
        progress_message = "Generating %s and %s from %s" %
                           (
                               ctx.outputs.source_out.short_path,
                               ctx.outputs.header_out.short_path,
                               ctx.file.src.short_path,
                           ),
        env = bison_info.bison_env,
    )

genyacc = rule(
    implementation = _genyacc_impl,
    doc = "Generate C/C++-language sources from a Yacc file using Bison.",
    attrs = {
        "src": attr.label(
            mandatory = True,
            allow_single_file = [".y", ".yy", ".yc", ".ypp"],
            doc = "The .y, .yy, or .yc source file for this rule",
        ),
        "header_out": attr.output(
            mandatory = True,
            doc = "The generated 'defines' header file",
        ),
        "source_out": attr.output(mandatory = True, doc = "The generated source file"),
        "prefix": attr.string(
            doc = "External symbol prefix for Bison. This string is " +
                  "passed to bison as the -p option, causing the resulting C " +
                  "file to define external functions named 'prefix'parse, " +
                  "'prefix'lex, etc. instead of yyparse, yylex, etc.",
        ),
        "extra_outs": attr.output_list(doc = "A list of extra generated output files."),
        "extra_options": attr.string_list(
            doc = "A list of extra options to pass to Bison.  These are " +
                  "subject to $(location ...) expansion.",
        ),
    },
    toolchains = ["@rules_bison//bison:toolchain_type"],
)
