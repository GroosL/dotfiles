#!/bin/bash
set -o errexit
 
# The locale may change the decimal point
LC_ALL=C
 
max_volume=65537  # Value of 'volume steps' in $(pacmd list-sinks)
max_percent=100
barwidth=20
 
action="$1"
sink="$2"
 
function usage_error {
    echo "Usage: $(basename $0) [+|-]PERCENT|mute|unmute|toggle [SINK]"
    exit 1
}
 
function calc {
    echo "scale=5; $@" | bc
}
 
function int {
    printf '%.0f' "$1"
}
 
function max {
    [ "$1" -gt "$2" ] && echo "$1" || echo "$2"
}
 
function min {
    [ "$1" -lt "$2" ] && echo "$1" || echo "$2"
}
 
function is_number {
    local value="$1"
    echo "$value" | grep -Poq '^[0-9]+(?:\.[0-9]+|)$' && true || false
}
 
function repeat {
    [ $2 -gt 0 ] && printf "$1%.0s" $(seq 1 $2)
}
 
if [ -z "$sink" ]; then
    # Use default sink
    sink="$(pacmd dump | grep '^set-default-sink ' | cut -d ' ' -f 2)"
elif echo "$sink" | grep -q '^[0-9]*$'; then
    # Convert sink's index to name
    sink="$(pacmd dump | grep '^set-sink-volume ' | sed -n "$(calc $sink+1)"p | cut -d ' ' -f 2)"
    if [ -z "$sink" ]; then
        echo "Invalid sink specifier" >&2
        exit 1
    fi
fi
 
function get_volume {
    int $(pacmd dump | grep "^set-sink-volume $sink" | cut -d ' ' -f 3)
}
 
function get_volume_percent {
    int $(calc "$(get_volume) / $max_volume * 100")
}
 
function adjust_volume {
    local adj="$1"
 
    if [[ "${adj:0:1}" = '+' || "${adj:0:1}" = '-' ]]; then
        # Relative volume
        local sign="${adj:0:1}"
        local percent="${adj:1}"
        is_number "$percent" || usage_error
        local adjustment="$(calc "$max_volume * $percent/100")"
        local new_volume="$(max 0 $(int $(calc "$(get_volume) $sign $adjustment")))"
    elif is_number "$adj"; then
        # Absolute volume
        local new_volume="$(int $(calc "$max_volume * $adj/100"))"
    else
        usage_error
    fi
 
    local max_allowed="$(int $(calc "$max_volume * $max_percent/100"))"
    pacmd set-sink-volume "$sink" "$(min $max_allowed $new_volume)"
}
 
function mute {
    pacmd set-sink-mute "$sink" 1
}
 
function unmute {
    pacmd set-sink-mute "$sink" 0
}
 
function is_muted {
    pacmd dump | grep -q "^set-sink-mute $sink yes" && true || false
}
 
function toggle {
    is_muted && unmute || mute
}
 
function display_volume {
    local percent=$(get_volume_percent)
    local stepsize=$(calc "100/$barwidth")
    local filled_width=$(min $barwidth $(int $(calc "$percent/$stepsize")))
    local unfilled_width=$(int $(calc "$barwidth - ($percent/$stepsize)"))
 
    if is_muted; then
        filled_char='▒'
        unfilled_char='░'
        speaker='🔇'
    else
        filled_char='█'
        unfilled_char='░'
        speaker='🔉'
    fi
 
    local line="▕${line}$(repeat "$filled_char" $filled_width)$(repeat "$unfilled_char" $unfilled_width)"
 
    if [ $percent -gt 100 ]; then
      line="${line}▶"
    else
      line="${line}▏"
    fi
    echo "$speaker$line$percent"
}
 
function osd {
    # Kill any previous osd instances
    pkill aosd_cat || true  # Ignore error code 1
    aosd_cat --position=7 \
        --font='Inconsolata bold 40' --fore-color=orange \
        --fade-in=150 --fade-full=350 --fade-out=500
}
 
case "$action" in
    mute)
        mute
        ;;
    unmute)
        unmute
        ;;
    toggle)
        toggle
        ;;
    show|display)
        ;;
    *)
        adjust_volume "$action"
        ;;
esac
 
if tty | grep -q '/pts/'; then
    display_volume
else
    # Dump stderr to suppress "Terminated" and "Broken pipe" messages that are a
    # result from killing the osd
    (display_volume 2>/dev/null | osd 2>/dev/null) &
fi
