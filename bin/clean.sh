#!/bin/bash 

[ ! -d archives ] && mkdir archives
mv CrashReports/* archives
mv traces/* archives
mv tmp/* archives
