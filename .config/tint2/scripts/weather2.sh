
#!/bin/bash
#
### ==========================================================
### Building on the original script from @Anachron's i3blocks,  
### @Addy's icon additions, @Nili's network-connection check,
### and using snippets from @Damo's bunsenweather script.
### Modifications for MX Linux by @ceeslans November 2020.
### ==========================================================
#
# requires 'jq' (a lightweight command-line JSON processor) to be installed !!!
#
#
#
### ==============================
### User settings ################ 
### ++++++++++++++++++++++++++++++

#API_KEY="enter-your-32-digit-api-key-here"  ### sign up at http://openweathermap.org/appid to obtain key
API_KEY="25226bc491d783dad6f3ad8090b00faa"

#PLACE="$1"			# [Default] --> the script will obtain your geo-location !
PLACE="3450083"	# enter your City ID (check http://openweathermap.org/find)

SYMBOL="˚C"			# setting the metric system (temperature in dgr Celcius)
#SYMBOL="˚F"			# setting the imperial system (temperature in dgr Fahrenheit)

ICONPATH="$HOME/.config/tint2/executors/icons/weather/papirus/"
#ICONPATH="$HOME/.config/tint2/executors/icons/weather/openweathermap/"



### ============================================================
### Don't change below script, unless you know what you're doing
### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

if [[ -z $PLACE ]] &>/dev/null;then
	ipinfo=$(curl -s ipinfo.io)
	latlong=$(echo "$ipinfo" | jq -r '.loc')
	lat=${latlong%,*}
	long=${latlong#*,}
	LOCATION="lat=$lat&lon=$long"
else
	[[ ${PLACE##*[!0-9]*} ]] &>/dev/null && LOCATION="id=$PLACE" || LOCATION="q=$PLACE"
fi

if ping -qc1 1.1.1.1 >/dev/null; then
	if [[ $SYMBOL = "˚F" ]]; then
		UNITS="imperial"
		WEATHER_URL="http://api.openweathermap.org/data/2.5/weather?${LOCATION}&appid=${API_KEY}&&units=${UNITS}"
	elif [[ $SYMBOL = "˚C" ]]; then
		UNITS="metric"
		WEATHER_URL="http://api.openweathermap.org/data/2.5/weather?${LOCATION}&appid=${API_KEY}&&units=${UNITS}"
	else
		echo "${ICONPATH}404.png"
		echo "Link Down"
	fi
fi

	WEATHER_INFO=$(wget -qO- "${WEATHER_URL}")
	WEATHER_ICON=$(echo "${WEATHER_INFO}" | grep -o -e '\"icon\":\"[0-9a-z]*\"' | awk -F ':' '{print $2}' | tr -d '"')	
	WEATHER_MAIN=$(echo "${WEATHER_INFO}" | grep -o -e '\"main\":\"[A-Za-z]*\"' | awk -F ':' '{print $2}' | tr -d '"')
	WEATHER_TEMP=$(echo "${WEATHER_INFO}" | grep -o -e '\"temp\":\-\?[0-9]*' | awk -F ':' '{print $2}' | tr -d '"')	
	WEATHER_TEXT=$(echo "${WEATHER_INFO}" | grep -o -e '\"description\":\"[a-z a-z]*' | awk -F ':' '{print $2}' | tr -d '"')

### =================
### Output to toolbar
### +++++++++++++++++

	echo "${ICONPATH}${WEATHER_ICON}"
	echo "${WEATHER_TEMP}${SYMBOL}" #- "${WEATHER_TEXT}"
