# if the skip geekbench flag was set, skip the system performance test, otherwise test system performance
if [ -z "$SKIP_GEEKBENCH" ]; then
	if [[ $GEEKBENCH_4 == *True* ]]; then
		launch_geekbench 4
	fi

	if [[ $GEEKBENCH_5 == *True* ]]; then
		launch_geekbench 5
	fi
fi
