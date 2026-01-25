repo=$(realpath "${args[repo]}")

echo "$repo"
check-realpath "$repo"
check-git-repository "$repo"
echo "Old description:"
show-descr "$repo"
echo "New description:"
echo -n "| "
read descr
echo
echo "$descr" > "$repo"/description
show-repo "$repo"

