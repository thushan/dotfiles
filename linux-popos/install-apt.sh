#!/usr/bin/env bash

source "$(dirname "${BASH_SOURCE[0]}")./scripts/console-colours.sh"

if [[ $EUID -ne 0 ]]; then
   die "Script needs to run elevated."
fi

while getopts u:a:f: flag
do
    case "${flag}" in        
        f) sourcefile=${OPTARG};;
    esac
done

[[ -z "$sourcefile" ]] && die "-f [sourcefile] missing."
[ ! -f "$sourcefile" ] && die "sourcefile '$sourcefile' does not exist."

show_info "Updating sources..."
apt update && apt upgrade || die 'Failed updating sources.'
show_success "Updating sources...done!"

show_info "Installing packages from '$sourcefile'..."
xargs -a <(awk '! /^ *(#|$)/' "$sourcefile") -r -- apt install
show_success "Installing packages from '$sourcefile'...Done!"