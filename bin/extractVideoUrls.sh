#! /bin/bash
grep \"video\"\:\ \" result.json  | sed 's/\t*"video": //g ; s/"//g ;  s/,//g'
