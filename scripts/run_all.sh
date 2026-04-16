#!/usr/bin/env bash
set -o pipefail

. "$(dirname "$0")/_config.sh"
{ set +x; } 2>/dev/null # trace is for child scripts, not this one

rm -f "$HOME/.dotfiles-notes"

PASS=()
FAIL=()

run_step() {
    local script="$1"
    local name
    name="$(basename "$script")"
    if [ -n "$DOT_VERBOSE" ]; then
        echo "--- $name ---"
        if "$script"; then
            echo "✔ $name"
            PASS+=("$name")
        else
            echo "✖ $name"
            FAIL+=("$name")
        fi
    else
        printf "  %-40s" "$name"
        if "$script" &>/dev/null; then
            echo "✔"
            PASS+=("$name")
        else
            echo "✖"
            FAIL+=("$name")
        fi
    fi
}

for script in "${DOT_ROOT}"/scripts/[0-9]*_setup_*.sh; do
    run_step "$script"
done

echo ""
echo "Results:"
for s in "${PASS[@]+"${PASS[@]}"}"; do echo "  ✔ $s"; done
for s in "${FAIL[@]+"${FAIL[@]}"}"; do echo "  ✖ $s"; done
echo ""
echo "${#PASS[@]} passed, ${#FAIL[@]} failed"

if [ -f "$HOME/.dotfiles-notes" ]; then
    echo ""
    echo "Notes:"
    while IFS= read -r line; do echo "  ! $line"; done <"$HOME/.dotfiles-notes"
    rm "$HOME/.dotfiles-notes"
fi

[ "${#FAIL[@]}" -eq 0 ]
