#!/bin/bash

# Define variables
DUMP_FILE="/tmp/primary_mongo_dump.archive"
REMOTE_PATH="/tmp"                              # Directory on backup VPS for backups
BACKUP_USER="root"                              # Username for backup VPS
BACKUP_HOST="172.0.0.1"                         # IP or hostname of the backup VPS
SSH_KEY="$HOME/.ssh/mongo_backup_key"           # Path to SSH private key

# Step 1: Create a MongoDB dump
echo "Creating MongoDB dump on primary VPS..."
mongodump --archive=$DUMP_FILE --gzip

# Step 2: Transfer the dump to the backup VPS using SFTP
echo "Transferring dump to backup VPS..."
sftp -i $SSH_KEY $BACKUP_USER@$BACKUP_HOST:$REMOTE_PATH <<< $'put '"$DUMP_FILE"

# Step 3: Clean up the dump file from the primary VPS
echo "Cleaning up dump file on this primary VPS..."
rm $DUMP_FILE

echo "Backup and transfer complete!"
