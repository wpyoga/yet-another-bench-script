#!/bin/bash

# Yet Another Bench Script by Mason Rowe
# Initial Oct 2019; Last update June 2021
#
# Disclaimer: This project is a work in progress. Any errors or suggestions should be
#             relayed to me via the GitHub project page linked below.
#
# Purpose:    The purpose of this script is to quickly gauge the performance of a Linux-
#             based server by benchmarking network performance via iperf3, CPU and
#             overall system performance via Geekbench 4/5, and random disk
#             performance via fio. The script is designed to not require any dependencies
#             - either compiled or installed - nor admin privileges to run.
#

# @MERGE
. steps/prologue.sh

# @MERGE
. steps/init.sh

# @MERGE
. steps/disk.sh

# @MERGE
. steps/network.sh

# @MERGE
. steps/cpu.sh

# @MERGE
. steps/epilogue.sh
