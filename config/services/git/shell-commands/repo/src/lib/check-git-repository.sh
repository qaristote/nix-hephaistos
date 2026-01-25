check-git-repository() {
    if [[ ! $(is-git-dir "$1") ]]
    then
        red "Not a git repository."
        exit 2
    fi
}
