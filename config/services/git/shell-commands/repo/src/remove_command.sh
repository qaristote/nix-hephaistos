path=$(realpath "${args[path]}")

check-realpath "$path"

if [[ $(is-git-dir "$path") ]]
then
    rm --recursive "$path"
else
    rm --dir "$path"
fi
