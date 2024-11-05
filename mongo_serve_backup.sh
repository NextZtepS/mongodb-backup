#!/bin/bash

# Define variables
LOCAL_BACKUP_PATH="/tmp/primary_mongo_dump.archive"     # Path to the local backup file

# Restore the backup to MongoDB
echo "Restoring backup to MongoDB on secondary server..."
mongorestore --archive="$LOCAL_BACKUP_PATH" --gzip

# Clean up the dump file from the primary VPS
echo "Cleaning up dump file from primary VPS..."
rm  $LOCAL_BACKUP_PATH

echo "Backup restoration complete!"
