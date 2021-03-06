#!/bin/bash

# Delay before starting
DELAY=3

# Sound notification to let one know when recording is about to start (and ends)
beep() {
    paplay /usr/share/sounds/KDE-Im-Irc-Event.ogg &
}

# Duration and output file
if [ $# -gt 0 ]; then
    D="--duration=$@"
else
    echo Default recording duration 10s to /tmp/recorded.gif
    D="--duration=10 /tmp/recorded.gif"
fi
XWININFO=$(xwininfo)
read X <<< 0
read Y <<< 0
read W <<< $(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f1)
read H <<< $(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f2)
# read X <<< $(awk -F: '/Absolute upper-left X/{print $2}' <<< "$XWININFO")
# read Y <<< $(awk -F: '/Absolute upper-left Y/{print $2}' <<< "$XWININFO")
# read W <<< $(awk -F: '/Width/{print $2}' <<< "$XWININFO")
# read H <<< $(awk -F: '/Height/{print $2}' <<< "$XWININFO")

echo Delaying $DELAY seconds. After that, byzanz will start
for (( i=$DELAY; i>0; --i )) ; do
    echo $i
    sleep 1
done

# beep
# echo "Starting Recording"
byzanz-record --verbose --delay=0 --x=$X --y=$Y --width=$W --height=$H $D &
sleep $(($1-1))
notify-send "Stopping Recording"

# beep
