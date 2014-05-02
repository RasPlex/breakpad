#!/bin/bash -xe
RPI_IP=192.168.0.10

echo "Copying crash reports"
scp -r root@$RPI_IP:.plexht/temp/CrashReports/ .

[ ! -d traces ] && mkdir traces

if [ -n "`find CrashReports -type f `" ];then
	for crash in `find CrashReports -type f `; do
		name=`basename $crash`
		./minidump_stackwalk $crash symbols  2> traces/${name}.err > traces/${name}.trace
	done
else
	echo "No crash reports to work with"
fi
