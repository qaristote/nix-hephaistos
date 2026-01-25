show-privacy() {
    local mode=$(( $(stat -c %a "$1")/10 %10 ))
    if [[ $mode == 0 ]]
    then
        red private
    elif [[ $mode == 5 ]]
    then
        green public
    else
        blue unknown
    fi
}
