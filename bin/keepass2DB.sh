#!/bin/bash
T=$(date +%Y%m%d_%H%M)
File=NewKSDatabase.kdbx
BackupFile=NewKSDatabase_${T}.kbdx
sDir=/home/klaseh/klaseh/work/Anteckningar/
dDir=/home/klaseh/Dokument/Dropbox/
#echo ${File}, ${dDir}, ${sDir},${t}
#echo ${dDir}${BackupFile} ${sDir}${File}

if [ -d ${sDir} ]; then
    if [ -e ${dDir}${File} ]; then
        echo Create date backup of ${dDir}${File}
        mv ${dDir}${File} ${dDir}${BackupFile}
    fi
    echo Copy file ${sDir}${File} to dropbox
    cp  ${sDir}${File} ${dDir}${File}
    ls -la ${dDir}New*.*
else
    echo Source directory ${sDir} not found.
    echo  key database not copied
fi
