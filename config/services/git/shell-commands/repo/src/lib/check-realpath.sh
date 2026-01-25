check-realpath() {
    local path="$1"
    if [[ ! -e "$path" ]] \
    || [[ ! "$path" == /srv/git/* ]]
    then
        red "Forbidden path."
        exit 2
    fi
}
