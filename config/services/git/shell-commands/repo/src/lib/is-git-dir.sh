is-git-dir() {
    git rev-parse --resolve-git-dir "$1" 2>/dev/null
}
