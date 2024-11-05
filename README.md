# Instruction on how to set up two MongoDB servers: primary and backup

## Download and Install Mongodb and Mongosh on the VPSs

Follow the instructions on [MongoDB Tutorial](https://www.mongodb.com/docs/manual/tutorial/install-mongodb-on-ubuntu/) and ensure that `mongod` is enabled on the `systemctl`.

## Create or use a SSH key for Secure File Transfer Process (SFTP)

On the primary server, we create a new SSH key for this backup process. If you have an existing key, you can use one as well.  
Then, we will send over the public key to the backup server.  
Modify the following shell commands to specify your backup server ip-address:
```shell
ssh-keygen -t ed25519 -f ~/.ssh/mongo_backup_key && \
ssh-copy-id -i ~/.ssh/mongo_backup_key.pub [user]@[backup-vps-ip]
```

You could check if such process is successful by try running:
```shell
sftp -i ~/.ssh/mongo_backup_key [user]@[backup-vps-ip]
```

## Set up a Cronjob on the servers

On the primary server put the [mongo_backup.sh](./mongo_backup.sh) in the home directory.  
Then, run `crontab -e` to and add the following cronjob to the file:
```
0 0 * * * /[user]/mongo_backup.sh  # run everyday at 12:00 AM
```
Add the execution permission to the file by running the following shell command:
```shell
chmod +x /[user]/mongo_backup.sh
```

On the backup server put the [mongo_serve_backup.sh](./mongo_serve_backup.sh)
Then, run `crontab -e` to and add the following cronjob to the file:
```
0 1 * * * /[user]/mongo_server_backup.sh  # run everyday at 1:00 AM
```
Add the execution permission to the file by running the following shell command:
```shell
chmod +x /[user]/mongo_serve_backup.sh
```

You can check if the cronjob is added by running `crontab -l`.
