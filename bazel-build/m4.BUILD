# Copyright 2009 Google Inc.
# All rights reserved.
#
# Description:
#   A BUILD file for m4-1.4.13-1 based on FSF stock source.

# default_hdrs_check is not set
package(
    default_visibility = ["//visibility:public"],
    features = [
        "-parse_headers",
        "no_layering_check",
    ],
)

licenses(["restricted"])  # GPLv3

# config_gen_files + generated_makefiles are generated by running ./configure
config_gen_files = [
    "config.status",
    "lib/config.h",
]

generated_makefiles = [
    "Makefile",
    "doc/Makefile",
    "lib/Makefile",
    "src/Makefile",
    "tests/Makefile",
    "checks/Makefile",
    "examples/Makefile",
]

# make_gen_files are generated by running 'make'
make_gen_files = [
    "lib/configmake.h",
    "lib/fcntl.h",
    "lib/math.h",
    "lib/signal.h",
    "lib/stdio.h",
    "lib/stdlib.h",
    "lib/string.h",
    "lib/sys/stat.h",
    "lib/sys/wait.h",
    "lib/unistd.h",
]

genrule(
    name = "m4_make",
    srcs = [
        "configure",
    ] + glob(
        ["**/*"],
        exclude = ["configure"],
    ),
    outs = config_gen_files + generated_makefiles + make_gen_files,
    cmd = "$(location configure) && " +
          " && ".join(["cp %s $(@D)/%s" % (f, f) for f in config_gen_files + generated_makefiles]) +
          " && make &&" +
          " && ".join(["cp %s $(@D)/%s" % (f, f) for f in make_gen_files]),
)

cc_library(
    name = "generated_files",
    srcs = ["lib/fcntl.c"],
    hdrs = [
        "lib/config.h",
        "lib/configmake.h",
        "lib/fcntl.h",
        "lib/math.h",
        "lib/signal.h",
        "lib/stdio.h",
        "lib/stdlib.h",
        "lib/string.h",
        "lib/sys/stat.h",
        "lib/sys/wait.h",
        "lib/unistd.h",
    ],
    includes = [
        ".",
        "lib",
    ],
)

cc_library(
    name = "unused_parameters",
    hdrs = ["build-aux/snippet/unused-parameter.h"],
    includes = [
        ".",
        "build-aux/snippet",
    ],
)

cc_library(
    name = "isnan",
    hdrs = ["lib/isnan.c"],
    includes = [
        ".",
        "lib",
    ],
    deps = [
        "m4_deps",
        ":generated_files",
    ],
    alwayslink = True,
)

cc_library(
    name = "regex_internal",
    hdrs = [
        "lib/regex_internal.c",
        "lib/regex_internal.h",
    ],
    includes = [
        ".",
        "lib",
    ],
)

func_def_hdrs = [
    "lib/msvc-inval.h",
    "lib/sig-handler.h",  # function 'get_handler'  [check]
    "lib/spawn-pipe.h",  # function 'create_pipe_in'
    "lib/unistd-safer.h",  # function 'fd_safer_flag', 'pipe_safer'
    "lib/xsize.h",  # function 'xsum', 'xmax', 'xsum4'   [check]
    "lib/filenamecat.h",  # function 'mfile_name_concat'
    "lib/fatal-signal.h",  # included by lib/spawn-pipe.c
    "lib/freading.h",  # included by lib/fclose.c
    "lib/wait-process.h",  # included by lib/spawn-pipe.c
    "lib/gettext.h",  # included by lib/spawn-pipe.c
]

func_def_srcs = [
    "lib/filenamecat-lgpl.c",  # function 'mfile_name_concat'
    "lib/sig-handler.c",  # function 'get_handler'
    "lib/unistd-safer.h",  # function 'fd_safer_flag', 'pipe_safer'
    "lib/dup-safer-flag.c",  # function 'dup_safer_flag'
    "lib/fd-safer-flag.c",  # function 'fd_safer_flag'
    "lib/pipe-safer.c",  # function 'pipe_safer'
    "lib/xsize.h",  # function 'xsum', 'xmax', 'xsum4'
    "lib/xsize.c",
    "lib/c-strcasecmp.c",  # function 'c_strcasecmp'
    "lib/spawn-pipe.c",  # function 'create_pipe_in'
    "lib/basename-lgpl.c",  # function 'last_component', 'base_len'
]

cc_library(
    name = "m4_deps",
    srcs =
        [
            "lib/c-ctype.c",
            "lib/c-strncasecmp.c",
            "lib/dirname.c",
            "lib/dirname-lgpl.c",
            "lib/getprogname.c",
            "lib/gl_list.c",
            "lib/gl_oset.c",
            "lib/gl_xlist.c",
            "lib/gl_xoset.c",
        ],
    hdrs =
        func_def_hdrs + [
            "lib/c-ctype.h",
            "lib/c-strcase.h",
            "lib/dirname.h",
            "lib/getprogname.h",
            "lib/gl_list.h",
            "lib/gl_oset.h",
            "lib/gl_xlist.h",
            "lib/gl_xoset.h",
            "lib/regexec.c",
            "lib/regcomp.c",
            "lib/regex_internal.c",
            "lib/c-strcaseeq.h",
            "lib/minmax.h",
            "lib/intprops.h",
            "lib/float+.h",
            "lib/quote.h",
            "lib/ignore-value.h",
            "lib/verify.h",
            "lib/stdio-impl.h",
            "lib/dosname.h",
            "lib/isnan.c",
            "lib/xalloc.h",  # depend on by gl_list library
            "lib/xalloc-oversized.h",
        ],
    includes = [
        ".",
        "lib",
    ],
    deps = [
        ":generated_files",
    ],
)

m4_bin_sources = [
    "lib/basename.c",
    "lib/config.h",
    "lib/binary-io.h",
    "lib/clean-temp.h",
    "lib/clean-temp.c",
    "lib/fclose.c",
    "lib/cloexec.c",
    "lib/cloexec.h",
    "lib/close-stream.h",
    "lib/close-stream.c",
    "lib/closein.h",
    "lib/closein.c",
    "lib/closeout.h",
    "lib/closeout.c",
    "lib/c-stack.h",
    "lib/c-stack.c",
    "lib/dup-safer.c",
    "lib/error.h",
    "lib/error.c",
    "lib/execute.h",
    "lib/execute.c",
    "lib/exitfail.h",
    "lib/exitfail.c",
    "lib/fatal-signal.h",
    "lib/fatal-signal.c",
    "lib/fflush.c",
    "lib/fd-safer.c",
    "lib/filenamecat.h",
    "lib/filenamecat.c",
    "lib/fopen-safer.c",
    "lib/freadahead.h",
    "lib/freadahead.c",
    "lib/freading.h",
    "lib/freading.c",
    "lib/fseeko.c",
    "lib/gettext.h",
    "lib/gl_avltree_oset.h",
    "lib/gl_avltree_oset.c",
    "lib/gl_linkedhash_list.h",
    "lib/gl_linkedhash_list.c",
    "lib/localcharset.h",
    "lib/localcharset.c",
    "lib/isnanl.c",
    "lib/malloca.c",
    "lib/malloca.h",
    "lib/math.h",
    "lib/memchr2.c",
    "lib/memchr2.h",
    "lib/mkstemp-safer.c",
    "lib/pathmax.h",
    "lib/progname.h",
    "lib/progname.c",
    "lib/printf-args.h",
    "lib/printf-args.c",
    "lib/printf-parse.h",
    "lib/printf-parse.c",
    "lib/quotearg.h",
    "lib/quotearg.c",
    "lib/regex.h",
    "lib/regex.c",
    "lib/stripslash.c",
    "lib/stdio--.h",
    "lib/stdlib--.h",
    "lib/string.h",
    "lib/strstr.c",
    "lib/tmpdir.h",
    "lib/tmpdir.c",
    "lib/unistd--.h",
    "lib/vasprintf.c",
    "lib/vasnprintf.c",
    "lib/vasnprintf.h",
    "lib/verror.h",
    "lib/verror.c",
    "lib/version-etc.h",
    "lib/version-etc.c",
    "lib/version-etc-fsf.c",
    "lib/wait-process.h",
    "lib/wait-process.c",
    "lib/xalloc.h",
    "lib/xalloc-die.c",
    "lib/xmalloc.c",
    "lib/xmalloca.c",
    "lib/xmalloca.h",
    "lib/xasprintf.c",
    "lib/xprintf.c",
    "lib/xprintf.h",
    "lib/xstrndup.c",
    "lib/xstrndup.h",
    "lib/xvasprintf.c",
    "lib/xvasprintf.h",
    "src/m4.c",
    "src/m4.h",
    "src/builtin.c",
    "src/debug.c",
    "src/eval.c",
    "src/format.c",
    "src/freeze.c",
    "src/input.c",
    "src/macro.c",
    "src/output.c",
    "src/path.c",
    "src/symtab.c",
] + func_def_srcs

cc_binary(
    name = "m4",
    srcs =
        m4_bin_sources + [
            "lib/configmake.h",
            "lib/fpending.h",
            "lib/fpucw.h",
            "lib/gl_anyhash_list1.h",
            "lib/gl_anyhash_list2.h",
            "lib/gl_anylinked_list1.h",
            "lib/gl_anylinked_list2.h",
            "lib/gl_anytree_oset.h",
            "lib/gl_list.h",
            "lib/gl_oset.h",
            "lib/isnanl-nolibm.h",
            "lib/obstack.h",
            "lib/regex_internal.h",
            "lib/stdio-safer.h",
            "lib/stdio.h",
            "lib/stdlib-safer.h",
            "lib/str-two-way.h",
            "lib/sys/wait.h",
            "lib/unlocked-io.h",
        ],
    copts = [
        "-Im4/lib",
        "-w",
    ],
    output_licenses = ["unencumbered"],
    deps = [
        ":generated_files",
        ":m4_deps",
        ":unused_parameters",
    ],
)
