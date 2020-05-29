package(default_visibility = ["//visibility:public"])

exports_files([
    "googletest/include/gtest/gtest.h",
    "googletest/include/gtest/gtest_prod.h",
])

cc_library(
    name = "p4c_gtest_includes",
    hdrs = glob([
        "googletest/include/gtest/gtest.h",
        "googletest/include/gtest/gtest_prod.h",
        "googletest/include/gtest/gtest-death-test.h",
        "googletest/include/gtest/gtest-message.h",
        "googletest/include/gtest/gtest-param-test.h",
        "googletest/include/gtest/gtest-printers.h",
        "googletest/include/gtest/gtest-test-part.h",
        "googletest/include/gtest/gtest-typed-test.h",
        "googletest/include/gtest/internal/*.h",
        "googletest/include/gtest/internal/custom/*.h",
    ]),
    includes = [
        "googletest/include",
    ],
    # This one throws a #error when compiled directly as part of hdrs.
    textual_hdrs = [
        "googletest/include/gtest/gtest_pred_impl.h",
    ],
    visibility = ["//visibility:public"],
)
