show-repo-summary() {
    local repo="$1"
    local name="${repo#/srv/git/}"
    local privacy=$(show-privacy "$repo")
    local size=$(show-size "$repo")
    printf "%-16s %4s " "$privacy" "$size"
    bold "$name"
}
