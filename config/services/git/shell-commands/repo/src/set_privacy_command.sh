path=$(realpath "${args[path]}")

check-realpath "$path"

case "${args[visibility]}" in
    public)
        mode="rX"
        ;;
    private)
        mode=""
        ;;
esac

chmod g="$mode" --recursive "$path"
args[--tree]=1
args[path]="$path"
repo_show_command
