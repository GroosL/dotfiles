#!/bin/bash

# I take this script from Anachron's i3blocks
# I only slightly modify this script to add an option to show icon
# I also remove the i3blocks specify script
# To make this works with tint2 executor, polybar custom script, dzen2 feeder, conkybar, lemonbar feeder, dunst notify, etc.
# 'weather -i' = with icon, 'weather' = text only
# Cheers!
# Addy

# Open Weather Map API code, register to http://openweathermap.org to get one ;)
API_KEY="25226bc491d783dad6f3ad8090b00faa"

# Check on http://openweathermap.org/find
CITY_ID="3450083"

ICON_SUNNY="☀️ Limpo"
ICON_CLOUDY="⛅️ Nublado"
ICON_RAINY="🌦 Chuvoso"
ICON_STORM="⛈ Tempestade"
ICON_SNOW=" Neve"
ICON_FOG=" Neblina"
ICON_MISC=" "

TEXT_SUNNY="Clear"
TEXT_CLOUDY="Cloudy"
TEXT_RAINY="Chuvoso"
TEXT_STORM="Storm"
TEXT_SNOW="Snow"
TEXT_FOG="Fog"

SYMBOL_CELSIUS="˚C"

WEATHER_URL="http://api.openweathermap.org/data/2.5/weather?id=${CITY_ID}&appid=${API_KEY}&units=metric"

WEATHER_INFO=$(wget -qO- "${WEATHER_URL}")
WEATHER_MAIN=$(echo "${WEATHER_INFO}" | grep -o -e '\"main\":\"[A-Za-z]*\"' | awk -F ':' '{print $2}' | tr -d '"')
WEATHER_TEMP=$(echo "${WEATHER_INFO}" | grep -o -e '\"temp\":\-\?[0-9]*' | awk -F ':' '{print $2}' | tr -d '"')

if [[ "${WEATHER_MAIN}" = *Snow* ]]; then
	if  [[ $1 = "-i" ]]; then
    echo "${ICON_SNOW} ${WEATHER_TEMP}${SYMBOL_CELSIUS}"
	else
    echo "${TEXT_SNOW} ${WEATHER_TEMP}${SYMBOL_CELSIUS}"
	fi
elif [[ "${WEATHER_MAIN}" = *Rain* ]] || [[ "${WEATHER_MAIN}" = *Drizzle* ]]; then
	if  [[ $1 = "-i" ]]; then
    echo "${ICON_RAINY} ${WEATHER_TEMP}${SYMBOL_CELSIUS}"
	else
    echo "${TEXT_RAINY} ${WEATHER_TEMP}${SYMBOL_CELSIUS}"
	fi
elif [[ "${WEATHER_MAIN}" = *Cloud* ]]; then
	if  [[ $1 = "-i" ]]; then
    echo "${ICON_CLOUDY} ${WEATHER_TEMP}${SYMBOL_CELSIUS}"
	else
    echo "${TEXT_CLOUDY} ${WEATHER_TEMP}${SYMBOL_CELSIUS}"
	fi
elif [[ "${WEATHER_MAIN}" = *Clear* ]]; then
	if  [[ $1 = "-i" ]]; then
    echo "${ICON_SUNNY} ${WEATHER_TEMP}${SYMBOL_CELSIUS}"
	else
    echo "${TEXT_SUNNY} ${WEATHER_TEMP}${SYMBOL_CELSIUS}"
	fi
elif [[ "${WEATHER_MAIN}" = *Fog* ]] || [[ "${WEATHER_MAIN}" = *Mist* ]]; then
	if  [[ $1 = "-i" ]]; then
    echo "${ICON_FOG} ${WEATHER_TEMP}${SYMBOL_CELSIUS}"
	else
    echo "${TEXT_FOG} ${WEATHER_TEMP}${SYMBOL_CELSIUS}"
	fi
else
	if  [[ $1 = "-i" ]]; then
    echo "${ICON_MISC} ${WEATHER_MAIN} ${WEATHER_TEMP}${SYMBOL_CELSIUS}"
	else
    echo "${WEATHER_MAIN} ${WEATHER_TEMP}${SYMBOL_CELSIUS}"
	fi	
fi
