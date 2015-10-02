i3status --config ~/.config/i3status/config | while :
do
  olaying=$(ncmpcpp --now-playing)
  echo "$playing | $line" || exit 1
done
