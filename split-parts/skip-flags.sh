# get any arguments that were passed to the script and set the associated skip flags (if applicable)
while getopts 'fdighr49' flag; do
	case "${flag}" in
		f) SKIP_FIO="True" ;;
		d) SKIP_FIO="True" ;;
		i) SKIP_IPERF="True" ;;
		g) SKIP_GEEKBENCH="True" ;;
		h) PRINT_HELP="True" ;;
		r) REDUCE_NET="True" ;;
		4) GEEKBENCH_4="True" && unset GEEKBENCH_5 ;;
		9) GEEKBENCH_4="True" && GEEKBENCH_5="True" ;;
		*) exit 1 ;;
	esac
done
