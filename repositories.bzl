load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

def _inja_archive_impl(ctx):
    ctx.download_and_extract(
        url = "https://github.com/pantor/inja/archive/v3.4.0.tar.gz",
        stripPrefix = "inja-3.4.0",
    )
    ctx.file("BUILD", """
cc_library(
    name = "inja",
    hdrs = glob(["include/inja/*.hpp"]),
    includes = ["include"],
    visibility = ["//visibility:public"],
    deps = ["@nlohmann_json//:json"],
)
""")

inja_archive = repository_rule(
    implementation = _inja_archive_impl,
)

def _inja_extension_impl(ctx):
    inja_archive(name = "inja")

inja_repo = module_extension(
    implementation = _inja_extension_impl,
)

# For com_github_p4lang_p4c_extension
def _p4c_extension_impl(ctx):
    # This just mocks the local repository that was created by p4c_deps macro
    ctx.file("BUILD", """
filegroup(
    name = "ir_extension",
    srcs = [],
    visibility = ["//visibility:public"],
)
""")

p4c_extension_repo = repository_rule(
    implementation = _p4c_extension_impl,
)

def _p4c_ext_module_impl(ctx):
    p4c_extension_repo(name = "com_github_p4lang_p4c_extension")

p4c_ext_repo = module_extension(
    implementation = _p4c_ext_module_impl,
)
