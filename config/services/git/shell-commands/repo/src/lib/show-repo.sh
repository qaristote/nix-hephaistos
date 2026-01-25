show-repo() {
    local repo="$1"
    show-repo-summary "$repo"
    printf "%13s" ""
    show-descr "$repo"
}
