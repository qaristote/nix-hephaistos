print_in_color() {
  local color="$1"
  shift
  if [[ "${NO_COLOR:-}" == "" ]]; then
    printf "$color%b\e[0m\n" "$*"
  else
    printf "%b\n" "$*"
  fi
}

red() { print_in_color "\e[31m" "$*"; }
green() { print_in_color "\e[32m" "$*"; }
blue() { print_in_color "\e[34m" "$*"; }
bold() { print_in_color "\e[1m" "$*"; }
