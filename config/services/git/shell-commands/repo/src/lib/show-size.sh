show-size() {
    du --human-readable --summarize "$1" | cut --field 1
}
