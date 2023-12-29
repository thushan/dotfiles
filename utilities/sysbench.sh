#!/usr/bin/env bash
################################################################################
# Sysbench Test Suite (basic)
# ---
# Portable script to test VPS/Linux machine performance.
# Output saved to sysbench.log
################################################################################
KEY=`tput setaf 7`
VALUE=`tput setaf 7`
INFO=`tput setaf 4`
WARN=`tput setaf 3`
TITLE=`tput setaf 4`
ERROR=`tput setaf 1`
SUCCESS=`tput setaf 2`
CONTEXT=`tput setaf 6`
BOLD=`tput smso`
UNBOLD=`tput rmso`
ENDMARKER=`tput sgr0`

show_info() {
    echo -e "${INFO}$1 ${ENDMARKER}"
	echo $1 >> sysbench.log
}

show_title() {
    echo -e "${TITLE}$1 ${ENDMARKER}"
}

show_keyvalue() {
    echo -e "${BOLD}${KEY}$1${ENDMARKER}:${UNBOLD} ${VALUE}$2 ${ENDMARKER}"
}
show_context() {
    echo -e "${CONTEXT}$1 ${ENDMARKER}"
}
show_success() {
    echo -e "${SUCCESS}$1 ${ENDMARKER}"
}
show_success_bold() {
    echo -e "${BOLD}${SUCCESS}SUCCESS:${UNBOLD} ${SUCCESS}$1 ${ENDMARKER}"
}
show_warning_bold() {
    echo -e "${BOLD}${WARN}WARNING:${UNBOLD} ${WARN}$1 ${ENDMARKER}"
}
show_error_bold() {
    echo -e "${BOLD}${ERROR}ERROR:${UNBOLD} ${ERROR}$1 ${ENDMARKER}" 1>&2
}
die() {
	show_error "$1" 1>&2
	exit 1
}

show_title "--[ SysBench Test Suite (basic) ] --"
show_keyvalue "Kernel" "$(uname -r)"
show_title "------------------------------------"

if [ ! -x "$(command -v sysbench)" ]; then
	show_warning_bold "Sysbench not found, installing..."
	if [[ $EUID -ne 0 ]]; then
		die "Script needs to run elevated."
	fi
	apt update && apt install -y sysbench
fi

show_success_bold "Sysbench installed :-)"

show_info "----| System Stats"

if [ -x "$(command -v lsusb)" ]; then
	{
		echo "----> lsusb"
		lsusb
	} >> sysbench.log
fi

if [ -x "$(command -v lscpu)" ]; then
	{
		echo "----> lscpu"
		lscpu
	} >> sysbench.log
fi
show_success "Completed: [OK]"

show_info "----| CPU Benchmark"
sysbench cpu --cpu-max-prime=20000 run >> sysbench.log
show_success "Completed: [OK]"

show_info "----| RAM Benchmark"
sysbench memory --memory-block-size=1K --memory-total-size=100G  run >> sysbench.log
show_success "Completed: [OK]"

show_info "----| Disk Benchmark"
show_context "...Prepare Disk Benchmark (5Gb)"
sysbench fileio --file-total-size=5G prepare &>/dev/null
show_context "...Running Disk Benchmark (60s)"
sysbench fileio --file-total-size=5G --file-test-mode=rndrw --time=60 --max-requests=0 run >> sysbench.log
show_context "...Cleanup Disk Benchmark"
sysbench fileio --file-total-size=5G cleanup &>/dev/null

show_success "Completed: [OK]"
show_info "----| Benchmark Output"
show_success "$(ls -sh sysbench.log)"
