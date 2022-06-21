echo "`lscpu | grep 'İşlemci MHz' | awk '{print $3}'| awk -F\. '{print $1}' | sed 's/./&,/1' | cut -c1-3` Ghz"
