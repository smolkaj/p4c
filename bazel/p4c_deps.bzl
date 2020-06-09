"""Load dependencies needed to compile p4c as a 3rd-party consumer."""

load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def p4c_deps():
    """Loads dependencies need to compile p4c."""
    if not native.existing_rule("com_github_p4lang_p4runtime"):
        http_archive(
            name = "com_github_p4lang_p4runtime",
            # TODO(smolkaj): Set this to something more permanent once
            # https://github.com/p4lang/p4runtime/pull/297 has been merged.
            urls = ["https://github.com/p4lang/p4runtime/archive/bazel.zip"],
            strip_prefix = "p4runtime-bazel/proto",
            sha256 = "69db7d93730c30aeb99da247f941ce8a80a403354e98079f5a5b9500a9a389b9",
        )
    if not native.existing_rule("com_github_nelhage_rules_boost"):
        git_repository(
            name = "com_github_nelhage_rules_boost",
            commit = "ed844db5990d21b75dc3553c057069f324b3916b",
            remote = "https://github.com/nelhage/rules_boost",
            shallow_since = "1576879360 -0800",
        )
    if not native.existing_rule("com_google_googletest"):
        http_archive(
            name = "com_google_googletest",
            urls = ["https://github.com/google/googletest/archive/release-1.10.0.tar.gz"],
            strip_prefix = "googletest-release-1.10.0",
            sha256 = "9dc9157a9a1551ec7a7e43daea9a694a0bb5fb8bec81235d8a1e6ef64c716dcb",
        )
    if not native.existing_rule("bison"):
        http_archive(
            name = "bison",
            build_file = "@com_github_p4lang_p4c//:bazel/bison.BUILD.bazel",
            sha256 = "0b36200b9868ee289b78cefd1199496b02b76899bbb7e84ff1c0733a991313d1",
            strip_prefix = "bison-3.5",
            urls = ["https://ftp.gnu.org/gnu/bison/bison-3.5.tar.gz"],
        )
    if not native.existing_rule("m4"):
        http_archive(
            name = "m4",
            build_file = "@com_github_p4lang_p4c//:bazel/m4.BUILD.bazel",
            patch_args = ["-p1"],
            patches = ["@com_github_p4lang_p4c//:bazel/m4.patch"],
            sha256 = "ab2633921a5cd38e48797bf5521ad259bdc4b979078034a3b790d7fec5493fab",
            strip_prefix = "m4-1.4.18",
            urls = ["https://ftp.gnu.org/gnu/m4/m4-1.4.18.tar.gz"],
        )
