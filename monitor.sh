echo "CPU Usage"
top -b -n 1 | grep "Cpu(s)" | awk '{print "CPU Usage: " $4+$6"%"}'
echo

echo "Memory Usage Function"
free -h | awk '/Mem/{print "Total: "$5", Used: "$3", Free:"$4}'
echo

echo "Disk Usage"
df -h --total | awk '/total/{print"Total Disk: "$4", Used: "$3",Free:"$2}'
echo

backup_folder() {
	local folder="${1:-.}"
	local timestamp=$(date +"%Y%m%d_%H%M%S")
	local folder_name=$(basename "$folder")
	local backup_name="${folder_name}_backup_${timestamp}.tar.gz"

	echo " Creating backup of '$folder' as '$backup_name'..."
	tar -czf "$backup_name" --ignore-failed-read  "$folder"

	if [ $? -eq 0 ]; then
		echo " Backup created successfully: $backup_name"
	else
		echo " Backup failed."
	fi
}

backup_folder "$1"
