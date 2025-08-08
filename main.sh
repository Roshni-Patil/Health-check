## Run this script to perform a health check on a remote server
# Ensure you have SSH access to the remote server and the script is executable. 
# This script will copy the health check script to the remote server, will run with root privileges, and clean up afterwards   
#!/bin/bash
source config.sh
# create working directory
mkdir -p /tmp/ws
echo "Enter server details for health check"
read -p "Enter username for SSH: " username
read -p "Enter Server IP: " hostname

REMOTE_USER="$username"
REMOTE_HOST="$hostname"
SCRIPT_LOCAL="script.sh config.sh"
SCRIPT_REMOTE="/tmp/ws"
# Copy the script
echo ""
echo " ---------  Enter password for copying script to remote server --------- "
scp $SCRIPT_LOCAL $REMOTE_USER@$REMOTE_HOST:$SCRIPT_REMOTE
echo ""
# Run the script
echo " ---------  Enter password for making script executable --------- "
ssh $REMOTE_USER@$REMOTE_HOST "chmod +x $SCRIPT_REMOTE/*.sh"
echo ""
echo " ---------  Enter password for executing script  ---------"
ssh $REMOTE_USER@$REMOTE_HOST "sudo bash $SCRIPT_REMOTE/script.sh"
echo ""
echo "Health check completed. Collecting logs to local server..."
read -p "Enter directory name to save logs: " directory
echo ""
echo " ---------  Enter password for copying logs to local server --------- "
scp ${REMOTE_USER}@${REMOTE_HOST}:$SCRIPT_REMOTE/logs/system* $directory/.
echo ""
echo "Cleaning up remote server..." 
ssh $REMOTE_USER@$REMOTE_HOST "sudo rm -rf $SCRIPT_REMOTE"
echo ""
echo "Health check logs have been copied to $directory." 
echo "You can view the logs at $directory/system_health_info_$time"
echo ""