#!/bin/bash

MONGODUMP_PATH="/usr/bin/mongodump"
 
TIMESTAMP=`date +%F-%H%M`
 
# Create backup. Use the linked mongodb docker container
$MONGODUMP_PATH --host mongodb:27017
  
# Add timestamp to backup
mv dump mongodb-$TIMESTAMP

# TAR this
tar cf /backups/mongodb-$TIMESTAMP.tar mongodb-$TIMESTAMP

# Remove our source directory
rm -rf mongodb-$TIMESTAMP

# Delete everything older than five days
find /backups/mongodb-* -mtime +10 -exec rm {} \;