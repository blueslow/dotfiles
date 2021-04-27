#! /bin/bash
youtube-dl -i  --external-downloader aria2c --external-downloader-args "-j 12 -s 12 -x 12 -k 5M --file-allocation=none --console-log-level=error --log-level=error --show-console-readout=false --quiet=true" $1 >>log.txt 2>>err.txt
