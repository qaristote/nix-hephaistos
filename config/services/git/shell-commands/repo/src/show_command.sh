if [[ -z "${args[path]}" ]]
then
    path=/srv/git/
else
    path=$(realpath "${args[path]}")
    check-realpath "$path"
fi

if [[ $(is-git-dir "$path") ]]
then
    args[--verbose]=1
fi

dirs=$(find "$path" -type f -name HEAD | while read -r head; do
           dir="${head%/*}"
           if [[ "${args[--tree]}" ]]
           then
               while [[ "$dir" != "/srv/git" && -n "$dir" ]]; do
                   echo "$dir/"
                   dir="${dir%/*}"
               done
           else
               echo "$dir/"
           fi
       done | sort -u)

for dir in $dirs
do
    if [[ "${args[--verbose]}" ]] && [[ $(is-git-dir "$dir") ]]
    then
        show-repo "$dir"
    else
        show-repo-summary "$dir"
    fi
done
