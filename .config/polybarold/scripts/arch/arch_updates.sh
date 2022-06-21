#!/usr/bin/env bash

path=${HOME}/.config/polybar/scripts/arch/
#trap 'exit' SIGINT

  main_loop() {
    while true; do
      echo '' > ${path}status
      echo '' > ${path}status_vcs
      check_for_updates
      check_for_vcs_updates
      sleep 600
    done
  }

  status() {
    echo $$ > ${path}polybar_updates.pid
    while true; do
      cat ${path}status
      sleep 1
    done
  }

  vcs_status() {
    echo $$ > ${path}polybar_vcs_updates.pid
    while true; do
      cat ${path}status_vcs
      sleep 1
    done
  }

  check_for_updates() {
    checkupdates | nl -w2 -s '. ' >| ${path}repo.pkgs
    paclist aurpkgs | aur vercmp | nl -w2 -s '. ' | sed 's/://' >| ${path}aur.pkgs
    updates=$(cat ${path}repo.pkgs ${path}aur.pkgs | wc -l)
    echo "%{T7}0%{T-}" >| ${path}status
    [ $updates -gt 0 ] && echo "%{T2}%{F#e60053}$updates" >| ${path}status
  }

  check_for_vcs_updates() {
    aur vercmp-devel | sed 's/://' | nl -w2 -s '. ' >| ${path}aur-vcs.pkgs
    updates=$(cat ${path}aur-vcs.pkgs | wc -l)
    echo "%{T7}0%{T-}" >| ${path}status_vcs
    [ $updates -gt 0 ] && echo "%{T2}%{F#e60053}$updates" >| ${path}status_vcs
  }

  notify() {
    if  [ -s ${path}repo.pkgs ]; then
      [ -s ${path}aur.pkgs ] && notify-send "$(cat <(cat ${path}repo.pkgs) <(echo) <(cat ${path}aur.pkgs | sed '1iAURUpdates') | \
                                column -t -L -o " " | sed 's/AURUpdates/AUR Updates/')" || notify-send "$(cat ${path}repo.pkgs | column -t -L -o " ")"
    elif  [ -s ${path}aur.pkgs ]; then
      notify-send "$(cat ${path}aur.pkgs | column -t -L -o " " | sed '1iAUR Updates')"
    else
      notify-send 0
    fi
  }

  vcs_notify() {
    [ -s ${path}aur-vcs.pkgs ] || notify-send 0
    [ -s ${path}aur-vcs.pkgs ] && notify-send "$(cat ${path}aur-vcs.pkgs | column -t -L -o " " | sed '1iAUR VCS Updates')"
  }

  upgrade() {
    if [ -s ${path}repo.pkgs ]; then
      [ -s ${path}aur.pkgs ] && urxvt -tr  -sh 20 -fg white -bg black -e sh -c "aur sync -c -u --noview && sudo pacman -Syu --noconfirm" || \
                                urxvt -tr  -sh 20 -fg white -bg black -e sh -c "sudo pacman -Syu --noconfirm"
      echo "%{T7}0%{T-}" > ${path}status && >| ${path}repo.pkgs && >| ${path}aur.pkgs
    elif [ -s ${path}aur.pkgs ]; then
      urxvt -tr  -sh 20 -fg white -bg black -e sh -c "aur sync -c -u --noview && sudo pacman -Syu --noconfirm"
      echo "%{T7}0%{T-}" > ${path}status && >| ${path}repo.pkgs && >| ${path}aur.pkgs
    else
      notify-send "No updates"
    fi
  }

  vcs_upgrade() {
    [ -s ${path}aur-vcs.pkgs ] || notify-send "No updates"
    [ -s ${path}aur-vcs.pkgs ] && urxvt -tr -sh 20 -fg white -bg black -e bash -ci \
                                  'mapfile -t packages < <(aur vercmp-devel | cut -d: -f1) && aur sync "${packages[@]}" --no-ver-shallow'
    echo "%{T7}0%{T-}" > ${path}status_vcs && >| ${path}aur-vcs.pkgs
  }

  clean() {
    urxvt -tr -sh 20 -fg white -bg black -e sh -c "clean_aurutils_cache && sudo pacman -Sc"
  }

  flagged() {
    url="https://www.archlinux.org/packages/"
    options="sort=&arch=any&arch=x86_64&repo=Community&repo=Core&repo=Extra&repo=Multilib&q=&maintainer=&flagged=Flagged"
    page_number=2
    status=1
    flagged_packages=$(curl "$url?$options" 2> /dev/null | \
                       grep "/packages/extra/\|/packages/core/\|/packages/community/\|/packages/multilib/\|<td>20\|span class=\"flagged\"")
    local_packages=$(pacman -Q |  sed 's/\(.*\ \)\(.*$\)/\1/')

    while [ $status -eq 1 ]; do
      flagged_packages+=$'\n'"$(curl $url?page=$page_number\&$options 2> /dev/null | \
                                grep "/packages/extra/\|/packages/core/\|/packages/community/\|/packages/multilib/\|<td>20\|error-page\|span class=\"flagged\"")"
      echo $flagged_packages | grep "error-page" > /dev/null
      status=$?
      page_number="$((page_number+1))"
    done

    flagged_packages=$(echo "$flagged_packages" | sed 'N;N;N;s/\n/ /g;s/">/ /g' | awk '{print $7,$11,($12),($13) }' | \
                       sed 's/<\/span><\/td>//;s/<td>/(/g;;s/<\/td>/)/g' | column -t -o " ")
    notify-send -t 60000 "$(cat <(echo "Outdated Repo packages") \
                          <(awk 'FNR==NR{a[$1];next}($1 in a){print}' <(echo "$local_packages")  <(echo "$flagged_packages") | nl -s '.') \
                          <(echo) \
                          <(echo "Outdated AUR packages") \
                          <(aur search -qi $(aur repo -a | sed 's/:.*//') | grep "Out-of-date" | sed -e 's/aur\///' -e 's/(.*%)//' | nl -s '.'))"
  }

  [[ $# -eq 0 ]] && main_loop
  [[ $1 == "-s" ]] && status
  [[ $1 == "-vs" ]] && vcs_status
  [[ $1 == "-q" ]] && echo '' > ${path}status && check_for_updates
  [[ $1 == "-vq" ]] && echo '' > ${path}status_vcs && check_for_vcs_updates
  [[ $1 == "-n" ]] && notify
  [[ $1 == "-vn" ]] && vcs_notify
  [[ $1 == "-u" ]] && upgrade
  [[ $1 == "-vu" ]] && vcs_upgrade
  [[ $1 == "-c" ]] && clean
  [[ $1 == "--flagged" ]] && flagged
