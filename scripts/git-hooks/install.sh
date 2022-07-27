GIT_HOOKS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ -z $1 || ! -d $1 || ! -d $1/.git ]]; then
    echo "Path to Development directory was not specified or isn't a directory or .git dir doesn't exist."
else
    dev_git_path="$1/.git/hooks"
    for hook in $GIT_HOOKS_DIR/*; do
        [[ $hook =~ .sh ]] && continue

        echo "copying $hook to $dev_git_path"
        cd $hook $dev_git_path
    done
fi