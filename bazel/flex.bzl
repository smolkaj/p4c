"""Build rule for generating C or C++ sources with Flex."""

def _genlex_impl(ctx):
    flex_toolchain = ctx.toolchains["@rules_flex//flex:toolchain_type"]
    flex_info = flex_toolchain.flex_toolchain

    args = ctx.actions.args()
    args.add("-o", ctx.outputs.out)
    args.add("-P", ctx.attr.prefix)
    args.add(ctx.file.src)

    ctx.actions.run(
        executable = flex_info.flex_tool,
        arguments = [args],
        inputs = [ctx.file.src] + ctx.files.includes,
        outputs = [ctx.outputs.out],
        mnemonic = "Flex",
        env = flex_info.flex_env,
    )

genlex = rule(
    implementation = _genlex_impl,
    doc = "Generate a C++ lexer from a lex file using Flex.",
    attrs = {
        "src": attr.label(mandatory = True, allow_single_file = [".l", ".ll", ".lex"]),
        "out": attr.output(mandatory = True),
        "prefix": attr.string(mandatory = True),
        "includes": attr.label_list(allow_files = True),
    },
    toolchains = ["@rules_flex//flex:toolchain_type"],
)
