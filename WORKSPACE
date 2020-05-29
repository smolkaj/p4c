workspace(name = "com_github_p4lang_p4c")

load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "bazel_skylib",
    sha256 = "97e70364e9249702246c0e9444bccdc4b847bed1eb03c5a3ece4f83dfe6abc44",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.0.2/bazel-skylib-1.0.2.tar.gz",
        "https://github.com/bazelbuild/bazel-skylib/releases/download/1.0.2/bazel-skylib-1.0.2.tar.gz",
    ],
)

load("@bazel_skylib//:workspace.bzl", "bazel_skylib_workspace")

bazel_skylib_workspace()

git_repository(
    name = "com_google_googleapis",
    commit = "84c8ad4e52f8eec8f08a60636cfa597b86969b5c",
    remote = "https://github.com/googleapis/googleapis",
    shallow_since = "1561669794 -0700",
)

load("@com_google_googleapis//:repository_rules.bzl", "switched_rules_by_language")

switched_rules_by_language(
    name = "com_google_googleapis_imports",
    cc = True,
    grpc = True,
    python = True,
)

http_archive(
    name = "com_google_protobuf",
    sha256 = "e8c7601439dbd4489fe5069c33d374804990a56c2f710e00227ee5d8fd650e67",
    strip_prefix = "protobuf-3.11.2",  # this is 3.11.2
    urls = ["https://github.com/protocolbuffers/protobuf/archive/v3.11.2.tar.gz"],
)

load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")

protobuf_deps()

http_archive(
    name = "com_github_grpc_grpc",
    sha256 = "0343e6dbde66e9a31c691f2f61e98d79f3584e03a11511fad3f10e3667832a45",
    strip_prefix = "grpc-1.29.1",  # this is 3.11.2
    urls = [
        "https://github.com/grpc/grpc/archive/v1.29.1.tar.gz",
    ],
)

load("@com_github_grpc_grpc//bazel:grpc_deps.bzl", "grpc_deps")

grpc_deps()

load("@com_github_grpc_grpc//bazel:grpc_extra_deps.bzl", "grpc_extra_deps")

grpc_extra_deps()

http_archive(
    name = "p4lang_p4runtime",
    build_file = "@//:bazel/p4runtime_proto.BUILD",
    strip_prefix = "p4runtime-fb437abd13dc2a3177256149582cc85c0c39f956/proto",
    urls = ["https://github.com/p4lang/p4runtime/archive/fb437abd13dc2a3177256149582cc85c0c39f956.zip"],
)

# Dependency of p4c
git_repository(
    name = "com_github_nelhage_rules_boost",
    commit = "ed844db5990d21b75dc3553c057069f324b3916b",
    remote = "https://github.com/nelhage/rules_boost",
    shallow_since = "1576879360 -0800",
)

load("@com_github_nelhage_rules_boost//:boost/boost.bzl", "boost_deps")

boost_deps()

http_archive(
    name = "p4c_gtest",
    build_file = "@//:bazel/gtest.BUILD",
    sha256 = "9dc9157a9a1551ec7a7e43daea9a694a0bb5fb8bec81235d8a1e6ef64c716dcb",
    strip_prefix = "googletest-release-1.10.0",
    urls = ["https://github.com/google/googletest/archive/release-1.10.0.tar.gz"],
    workspace_file_content = """workspace(name = "my_custom_googletest")""",
)

http_archive(
    name = "bison",
    build_file = "@//:bazel/bison.BUILD",
    sha256 = "0b36200b9868ee289b78cefd1199496b02b76899bbb7e84ff1c0733a991313d1",
    strip_prefix = "bison-3.5",
    urls = ["https://ftp.gnu.org/gnu/bison/bison-3.5.tar.gz"],
)

http_archive(
    name = "m4",
    build_file = "@//:bazel/m4.BUILD",
    patch_args = ["-p1"],
    patches = ["@//:bazel/m4.patch"],
    sha256 = "ab2633921a5cd38e48797bf5521ad259bdc4b979078034a3b790d7fec5493fab",
    strip_prefix = "m4-1.4.18",
    urls = ["https://ftp.gnu.org/gnu/m4/m4-1.4.18.tar.gz"],
)
