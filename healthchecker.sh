#!/bin/bash

# all hosts listed here, separated by space
ALL_HOSTS=(192.168.9.1 192.168.9.2 192.168.9.3 192.168.9.4 192.168.9.5)

for host in ${ALL_HOSTS[*]}
do
{
    start_time=$(date +'%s')
    ssh $host "hostname" &>/dev/null
    sleep 5
    stop_time=$(date +'%s')
    time_consuming=$((stop_time-start_time))
    echo "$host: $time_consuming" >>hostname.txt
}&
done

wait

host=$(sort -n -k 2 hostname.txt | tail -1 | awk -F':' '{print $1}')

ssh $host "top -b -n 1"
