#!/usr/bin/env bash

ERROR=`tput setaf 1`
WARN=`tput setaf 3`
INFO=`tput setaf 4`
SUCCESS=`tput setaf 2`
BOLD=`tput smso`
UNBOLD=`tput rmso`
ENDMARKER=`tput sgr0`

show_error() {
    echo -e "${BOLD}${ERROR}ERROR:${UNBOLD} ${ERROR}$1 ${ENDMARKER}" 1>&2
}

show_warning() {
    echo -e "${BOLD}${WARN}WARNING:${UNBOLD} ${WARN}$1 ${ENDMARKER}"
}

show_info() {
    echo -e "${INFO}$1 ${ENDMARKER}"
}

show_success() {
    echo -e "${SUCCESS}$1 ${ENDMARKER}"
}
die() {
     show_error "$1" 1>&2
     exit 1
}
