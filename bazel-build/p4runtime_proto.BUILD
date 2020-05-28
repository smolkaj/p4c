load("@com_github_grpc_grpc//bazel:cc_grpc_library.bzl", "cc_grpc_library")
load("@com_github_grpc_grpc//bazel:python_rules.bzl", "py_grpc_library", "py_proto_library")

package(default_visibility = ["//visibility:public"])

exports_files(
    glob(["**/*.proto"]),
    visibility = [
        "//p4lang_p4c:__subpackages__",
        "//p4lang_p4runtime:__subpackages__",
    ],
)

proto_library(
    name = "p4info_proto",
    srcs = ["p4/config/v1/p4info.proto"],
    deps = [
        ":p4types_proto",
        "@com_google_protobuf//:any_proto",
    ],
)

cc_proto_library(
    name = "p4info_cc_proto",
    deps = [":p4info_proto"],
)

py_proto_library(
    name = "p4info_py_pb2",
    deps = [":p4info_proto"],
)

proto_library(
    name = "p4types_proto",
    srcs = ["p4/config/v1/p4types.proto"],
)

cc_proto_library(
    name = "p4types_cc_proto",
    deps = [":p4types_proto"],
)

proto_library(
    name = "p4runtime_proto",
    srcs = ["p4/v1/p4runtime.proto"],
    deps = [
        ":p4data_proto",
        ":p4info_proto",
        "@com_google_googleapis//google/rpc:status_proto",
        "@com_google_protobuf//:any_proto",
    ],
)

cc_proto_library(
    name = "p4runtime_cc_proto",
    deps = [":p4runtime_proto"],
)

cc_grpc_library(
    name = "p4runtime_cc_grpc_proto",
    srcs = [":p4runtime_proto"],
    grpc_only = True,
    deps = [":p4runtime_cc_proto"],
)

proto_library(
    name = "p4data_proto",
    srcs = ["p4/v1/p4data.proto"],
)

cc_proto_library(
    name = "p4data_cc_proto",
    deps = [":p4data_proto"],
)
