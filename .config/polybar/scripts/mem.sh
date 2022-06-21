echo " `free -m | awk '/Mem:/ { printf("%3.2f", $3/1000)}'` GiB  "
