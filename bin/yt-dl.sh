#!/bin/bash
YOU=/usr/local/bin/youtube-dl
echo $@
${YOU} --external-downloader aria2c --external-downloader-args "-j 12 -s 12 -x 12 -k 5M" -i $@
