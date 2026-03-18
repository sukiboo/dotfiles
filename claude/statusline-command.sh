#!/usr/bin/env bash
input=$(cat)

# colors
rst='\033[00m'
dim='\033[02m'
red='\033[31m'
grn='\033[32m'
ylw='\033[33m'
blu='\033[34m'
pur='\033[35m'
cyn='\033[36m'
bgrn='\033[01;32m'
bblu='\033[01;34m'

sep="  "

# format large numbers compactly (max 4 chars + suffix)
fmt_num() {
  local n=${1:-0}
  if   [ "$n" -lt 1000 ];        then echo "$n"
  elif [ "$n" -lt 10000 ];       then printf "%.2fk" "$(echo "$n / 1000" | bc -l)"
  elif [ "$n" -lt 100000 ];      then printf "%.1fk" "$(echo "$n / 1000" | bc -l)"
  elif [ "$n" -lt 1000000 ];     then printf "%.0fk"  "$(echo "$n / 1000" | bc -l)"
  elif [ "$n" -lt 10000000 ];    then printf "%.2fm" "$(echo "$n / 1000000" | bc -l)"
  elif [ "$n" -lt 100000000 ];   then printf "%.1fm" "$(echo "$n / 1000000" | bc -l)"
  elif [ "$n" -lt 1000000000 ];  then printf "%.0fm"  "$(echo "$n / 1000000" | bc -l)"
  elif [ "$n" -lt 10000000000 ]; then printf "%.2ft" "$(echo "$n / 1000000000" | bc -l)"
  else                                printf "%.1ft" "$(echo "$n / 1000000000" | bc -l)"
  fi
}

# parse input (single jq call)
eval "$(echo "$input" | jq -r '
  @sh "cwd=\(.cwd)",
  @sh "model_id=\(.model.id)",
  @sh "version=\(.version)",
  @sh "used_pct=\(.context_window.used_percentage // empty)",
  @sh "ctx_size=\(.context_window.context_window_size // empty)",
  @sh "input_tokens=\(.context_window.current_usage.cache_read_input_tokens // empty)",
  @sh "output_tokens=\(.context_window.total_output_tokens // empty)",
  @sh "cost=\(.cost.total_cost_usd // empty)",
  @sh "lines_add=\(.cost.total_lines_added // empty)",
  @sh "lines_rem=\(.cost.total_lines_removed // empty)"
')"

# derived values
chroot_prefix=""
if [ -n "${debian_chroot:-}" ]; then
  chroot_prefix="($debian_chroot)"
fi

cwd_slashes="${cwd//[^\/]}"
if [ "${#cwd_slashes}" -lt 3 ]; then
  short_cwd="$cwd"
else
  short_cwd=".../$(basename "$(dirname "$cwd")")/$(basename "$cwd")"
fi

ctx_pct=$(printf "%.0f%%" "${used_pct:-0}")
ctx_size_k="${ctx_size:+$(( ctx_size / 1000 ))k}"
ctx_size_k="${ctx_size_k:-?}"
cost_str=$(printf "\$%.2f" "${cost:-0}")
in_fmt=$(fmt_num "${input_tokens:-0}")
out_fmt=$(fmt_num "${output_tokens:-0}")

# print statusline
printf "%s"                                                 "$chroot_prefix"
if [ "${TERM_PROGRAM:-}" != "vscode" ]; then
  printf "${bgrn}%s:${rst}${bblu}%s${rst}"                  "$(whoami)" "$short_cwd"
  printf "${sep}"
fi
printf "${blu}%s${rst}"                                     "$model_id"
printf "${sep}${ylw}%s${rst}${dim}/${rst}${ylw}%s${rst}"    "$ctx_pct" "$ctx_size_k"
printf "${sep}${grn}+%s${rst}${dim}/${rst}${red}-%s${rst}"  "${lines_add:-0}" "${lines_rem:-0}"
printf "${sep}${cyn}%s↑${rst} ${cyn}%s↓${rst}"              "$in_fmt" "$out_fmt"
printf "${sep}${pur}%s${rst}"                               "$cost_str"
printf "${sep}${dim}v%s${rst}"                              "$version"
