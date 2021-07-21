# print help and exit script, if help flag was passed
if [ ! -z "$PRINT_HELP" ]; then
	echo -e
	echo -e "Usage: ./yabs.sh [-fdighr49]"
	echo -e "       curl -sL yabs.sh | bash"
	echo -e "       curl -sL yabs.sh | bash -s -- -{fdighr49}"
	echo -e
	echo -e "Flags:"
	echo -e "       -f/d : skips the fio disk benchmark test"
	echo -e "       -i : skips the iperf network test"
	echo -e "       -g : skips the geekbench performance test"
	echo -e "       -h : prints this lovely message, shows any flags you passed,"
	echo -e "            shows if fio/iperf3 local packages have been detected,"
	echo -e "            then exits"
	echo -e "       -r : reduce number of iperf3 network locations (to only three)"
	echo -e "            to lessen bandwidth usage"
	echo -e "       -4 : use geekbench 4 instead of geekbench 5"
	echo -e "       -9 : use both geekbench 4 AND geekbench 5"
	echo -e
	echo -e "Detected Arch: $ARCH"
	echo -e
	echo -e "Detected Flags:"
	[[ ! -z $SKIP_FIO ]] && echo -e "       -f/d, skipping fio disk benchmark test"
	[[ ! -z $SKIP_IPERF ]] && echo -e "       -i, skipping iperf network test"
	[[ ! -z $SKIP_GEEKBENCH ]] && echo -e "       -g, skipping geekbench test"
	[[ ! -z $REDUCE_NET ]] && echo -e "       -r, using reduced (3) iperf3 locations"
	[[ ! -z $GEEKBENCH_4 ]] && echo -e "       running geekbench 4"
	[[ ! -z $GEEKBENCH_5 ]] && echo -e "       running geekbench 5"
	echo -e
	echo -e "Local Binary Check:"
	[[ -z $LOCAL_FIO ]] && echo -e "       fio not detected, will download precompiled binary" ||
		echo -e "       fio detected, using local package"
	[[ -z $LOCAL_IPERF ]] && echo -e "       iperf3 not detected, will download precompiled binary" ||
		echo -e "       iperf3 detected, using local package"
	echo -e
	echo -e "Detected Connectivity:"
	[[ ! -z $IPV4_CHECK ]] && echo -e "       IPv4 connected" ||
		echo -e "       IPv4 not connected"
	[[ ! -z $IPV6_CHECK ]] && echo -e "       IPv6 connected" ||
		echo -e "       IPv6 not connected"
	echo -e
	echo -e "Exiting..."

	exit 0
fi
