#!/usr/bin/env bash

get_metadata() {
    arg="$1"
    playerctl metadata --format "{{ $arg }}" 2>/dev/null
}

get_source_info() {
    trackid=$(get_metadata "mpris:trackid")

    if [[ "$trackid" == *"brave"* ]]; then
        echo "Brave Browser"
    fi
}

format_duration() {
    duration="$1"

    if [[ -z "$duration" ]]; then
        echo "00:00"
        return
    fi

    # Convert microseconds to seconds
    remain=$((duration / 1000000))
    minute=$((remain / 60))
    second=$((remain % 60))

    printf "%02d:%02d\n" "$minute" "$second"
}

pos() {
    # Get the position of the currently playing track
    position=$(playerctl position 2>/dev/null)
    
    if [[ -z "$position" ]]; then
        echo "00:00"
        return
    fi

    position=${position%.*}  # Remove decimal part if present

    minute=$((position / 60))
    second=$((position % 60))

    printf "%02d:%02d\n" "$minute" "$second"
}

case "$1" in
    --title)
        title=$(get_metadata "xesam:title")
        if [ -z "$title" ]; then
            echo "Nothing Playing"
        else
            echo "$title"
		fi
        ;;
    --artist)
        artist=$(get_metadata "xesam:artist")
        if [ -z "$artist" ]; then
            echo "---"
        else
            echo "$artist"
        fi
        ;;
    --art)
        url=$(get_metadata "mpris:artUrl")
        if [ -z "$url" ]; then
            echo ""
        else
            if [[ "$url" == file://* ]]; then
				url=${url#file://}
            fi
            echo "$url"
        fi
        ;;
    --status)
		status=$(playerctl status 2>/dev/null)
		if [[ $status == "Playing" ]]; then
			echo "Now Playing in $(get_source_info)"
		elif [[ $status == "Paused" ]]; then
			echo "Paused"
		else
			echo "Stopped"
		fi
		;;
    --progress)
        echo "$(pos) / $(format_duration "$(get_metadata "mpris:length")")"
        ;;
    *)
        echo "Usage: $0 {--title|--art|--status|--artist|--progress}"
        exit 1
        ;;
esac