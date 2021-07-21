# if the skip iperf flag was set, skip the network performance test, otherwise test network performance
if [ -z "$SKIP_IPERF" ]; then

	if [ ! -z "$LOCAL_IPERF" ]; then # local iperf has been detected, use instead of pre-compiled binary
		IPERF_CMD=iperf3
	else
		# create a temp directory to house the required iperf binary and library
		IPERF_PATH=$YABS_PATH/iperf
		mkdir -p $IPERF_PATH

		# download iperf3 binary
		if [ ! -z "$IPV4_CHECK" ]; then # if IPv4 is enabled
			curl -s -4 --connect-timeout 5 --retry 5 --retry-delay 0 https://raw.githubusercontent.com/masonr/yet-another-bench-script/master/bin/iperf3_$ARCH -o $IPERF_PATH/iperf3
		else # no IPv4, use IPv6 - below is necessary since raw.githubusercontent.com has no AAAA record
			curl -s -6 --connect-timeout 5 --retry 5 --retry-delay 0 -k -g --header 'Host: raw.githubusercontent.com' https://[2a04:4e42::133]/masonr/yet-another-bench-script/master/bin/iperf3_$ARCH -o $IPERF_PATH/iperf3
		fi

		if [ ! -f "$IPERF_PATH/iperf3" ]; then # ensure iperf3 binary downloaded successfully
			IPERF_DL_FAIL=True
		else
			chmod +x $IPERF_PATH/iperf3
			IPERF_CMD=$IPERF_PATH/iperf3
		fi
	fi
	
	# array containing all currently available iperf3 public servers to use for the network test
	# format: "1" "2" "3" "4" "5" \
	#   1. domain name of the iperf server
	#   2. range of ports that the iperf server is running on (lowest-highest)
	#   3. friendly name of the host/owner of the iperf server
	#   4. location and advertised speed link of the iperf server
	#   5. network modes supported by the iperf server (IPv4 = IPv4-only, IPv4|IPv6 = IPv4 + IPv6, etc.)
	IPERF_LOCS=( \
		"lon.speedtest.clouvider.net" "5200-5209" "Clouvider" "London, UK (10G)" "IPv4|IPv6" \
		"ping.online.net" "5200-5209" "Online.net" "Paris, FR (10G)" "IPv4" \
		"ping6.online.net" "5200-5209" "Online.net" "Paris, FR (10G)" "IPv6" \
		"iperf.worldstream.nl" "5201-5201" "WorldStream" "The Netherlands (10G)" "IPv4|IPv6" \
		"iperf.biznetnetworks.com" "5201-5203" "Biznet" "Jakarta, Indonesia (1G)" "IPv4" \
		"nyc.speedtest.clouvider.net" "5200-5209" "Clouvider" "NYC, NY, US (10G)" "IPv4|IPv6" \
		"iperf3.velocityonline.net" "5201-5210" "Velocity Online" "Tallahassee, FL, US (10G)" "IPv4" \
		"la.speedtest.clouvider.net" "5200-5209" "Clouvider" "Los Angeles, CA, US (10G)" "IPv4|IPv6" \
		"speedtest.iveloz.net.br" "5201-5209" "Iveloz Telecom" "Sao Paulo, BR (2G)" "IPv4" \
	)

	# if the "REDUCE_NET" flag is activated, then do a shorter iperf test with only three locations
	# (Clouvider London, Clouvider NYC, and Online.net France)
	if [ ! -z "$REDUCE_NET" ]; then
		IPERF_LOCS=( \
			"lon.speedtest.clouvider.net" "5200-5209" "Clouvider" "London, UK (10G)" "IPv4|IPv6" \
			"ping.online.net" "5200-5209" "Online.net" "Paris, FR (10G)" "IPv4" \
			"ping6.online.net" "5200-5209" "Online.net" "Paris, FR (10G)" "IPv6" \
			"nyc.speedtest.clouvider.net" "5200-5209" "Clouvider" "NYC, NY, US (10G)" "IPv4|IPv6" \
		)
	fi
	
	# get the total number of iperf locations (total array size divided by 5 since each location has 5 elements)
	IPERF_LOCS_NUM=${#IPERF_LOCS[@]}
	IPERF_LOCS_NUM=$((IPERF_LOCS_NUM / 5))
	
	if [ -z "$IPERF_DL_FAIL" ]; then
		# check if the host has IPv4 connectivity, if so, run iperf3 IPv4 tests
		[ ! -z "$IPV4_CHECK" ] && launch_iperf "IPv4"
		# check if the host has IPv6 connectivity, if so, run iperf3 IPv6 tests
		[ ! -z "$IPV6_CHECK" ] && launch_iperf "IPv6"
	else
		echo -e "\niperf3 binary download failed. Skipping iperf network tests..."
	fi
fi
