repo=$(realpath --canonicalize-missing /srv/git/"${args[repo]}")

if [[ ! "$repo" == /srv/git/* ]]
then
    red "Forbidden path."
    exit 2
fi

subpath=/srv/git
IFS='/' read -ra dirs <<< "${repo#/srv/git/}"
for dir in "${dirs[@]}"; do
    subpath="$subpath/$dir"
    if [[ ! -d "$subpath" ]]
    then
       break
    fi
done

mkdir --parents "$repo"
chmod u=rwX,g=,o= --recursive "$subpath"
git init --bare "$repo"

args[path]="$repo"
args[--tree]=1
repo_show_command
