#!/bin/sh

[ -n "$DOT_VERBOSE" ] && set -x

confirm_binaries() {
    for x in "$@"; do
        if command -v "${x}" >/dev/null 2>&1; then
            echo "✔ ...confirming: $x"
        else
            echo "⛌ ...missing: $x"
            exit 1
        fi
    done
}

case "$(uname -s)" in
Darwin)
    export DOT_OS='darwin'
    ;;
Linux)
    export DOT_OS='linux'
    ;;
CYGWIN* | MINGW32* | MSYS* | MINGW*)
    export DOT_OS='windows'
    ;;
*)
    export DOT_OS='other'
    ;;
esac

this_folder="$(
    cd "$(dirname "$0")" >/dev/null 2>&1
    pwd -P
)"
export DOT_ROOT="$(dirname "$this_folder")"
