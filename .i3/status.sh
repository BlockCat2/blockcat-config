#!/bin/bash
# $HOME/.config/i3/status.sh
# ------------------------------------------------------
# Dzen settings & Variables
# -------------------------
SLEEP=1
ICONPATH="/home/emperor/.icons/power"
COLOR_ICON="#37AACF"
CRIT_COLOR="#37AACF" #"#ff2c4a"
DZEN_FG="#A0A0A0"
DZEN_BG="#101010"
HEIGHT=14
WIDTH=1680
X=500
Y=0
BAR_FG="#37AACF"
BAR_BG="#4c4c4c"
BAR_H=7
BAR_W=80
FONT='cure'
VUP="amixer set Master 2dB+"
VDOWN="amixer set Master 2dB-"
EVENT="button3=exit;button1=exec:'$VUP';button2=exec:'$VDOWN';"
DZEN="dzen2 -x $X -y $Y -w $WIDTH -h $HEIGHT -fn $FONT -ta right -bg $DZEN_BG -fg $DZEN_FG"

# -------------
# Infinite loop
# -------------
while :; do
sleep ${SLEEP}

# ---------
# Functions
# ---------
Bat () 
{
BAT=$(battery)
  echo -n "^fg($COLOR_ICON)^i($ICONPATH/battery.xbm)^fg() ${BAT}"
  return
}

Vol ()
{
	VOL=$(pamixer --sink 10 --get-volume  | tr -d '%' | uniq)
	echo -n "^fg($COLOR_ICON)^i($ICONPATH/volume.xbm)^fg() ($VOL%)" #$(echo $VOL | gdbar -fg $BAR_FG -bg $BAR_BG -h $BAR_H -w $BAR_W -s o -sw 2 -nonl)
  return
}

Mem ()
{
	#MEM=$(free -m | grep '-' | awk '{print $3}')
	MEM=$(free -m | awk '{print $3}' | tail -n 2 | head -n 1)
	echo -n "^fg($COLOR_ICON)^i($ICONPATH/mem1.xbm)^fg() ${MEM} MB"
	return
}

Temp ()
{
	TEMP=$(acpi -t | awk '{print $4}' | tr -d '.0')
		if [[ ${TEMP} -gt 63 ]] ; then
			echo -n "^fg($CRIT_COLOR)^i($ICONPATH/temp.xbm)^fg($CRIT_COLOR) ${TEMP}°C" $(echo ${TEMP} | gdbar -fg $CRIT_COLOR -bg $BAR_BG -h $BAR_H -s v -sw 5 -ss 0 -sh 1 -nonl)
		else 
			echo -n "^fg($COLOR_ICON)^i($ICONPATH/temp.xbm)^fg() ${TEMP}°C" $(echo ${TEMP} | gdbar -fg $BAR_FG -bg $BAR_BG -h $BAR_H -s v -sw 5 -ss 0 -sh 1 -nonl)
		fi
	return
}

Disk ()
{
	SDA2=$(df -h / | awk '/\/$/ {print $5}' | tr -d '%')
	SDB1=$(df -h /home | awk '/home/ {print $5}' | tr -d '%')
#	if [[ ${SDA2} -gt 60 ]] ; then
		echo -n "^fg($COLOR_ICON)^i($ICONPATH/file1.xbm)^fg() $(echo $SDA2 | gdbar -fg $CRIT_COLOR -bg $BAR_BG -h $BAR_H -w $BAR_W -s o -sw 2 -nonl)"
#	else
#		echo -n "^fg($COLOR_ICON)^i($ICONPATH/file1.xbm)^fg() $(echo $SDA2 | gdbar -fg $BAR_FG -bg $BAR_BG -h $BAR_H -w $BAR_W -s o -sw 2 -nonl)"
#	fi
#	if [[ ${SDB1} -gt 80 ]] ; then
#		echo -n " ^fg($COLOR_ICON)^i($ICONPATH/home.xbm)^fg() $(echo $SDB1 | gdbar -fg $CRIT_COLOR -bg $BAR_BG -h $BAR_H -w $BAR_W -s o -sw 2 -nonl)"
#	else
#		echo -n " ^fg($COLOR_ICON)^i($ICONPATH/home.xbm)^fg() $(echo $SDB1 | gdbar -fg $BAR_FG -bg $BAR_BG -h $BAR_H -w $BAR_W -s o -sw 2 -nonl)"
#	fi
	return
}

MPD ()
{
	MPDPLAYING=$(mpc | grep -c "playing")
	MPDSONG=$(mpc | head -n1)
  MPDPAUSED=$(mpc | grep -c "paused")
	MPDINFO=$(mpc | grep -v 'volume:' | head -n1)
	MPDTIME=$(mpc | awk '/\%/ {print $4}' | tr -d "()%")
	if [ $MPDPLAYING -eq 1 ] ; then
		echo -n "^fg($COLOR_ICON)^i($ICONPATH/music.xbm)^fg() [playing] $MPDSONG $(echo $MPDTIME | gdbar -fg $BAR_FG -bg $BAR_BG -h $BAR_H -w $BAR_W -s o -sw 2 -ss 1 -nonl)"
	else
		if [ $MPDPAUSED -eq 1 ] ; then
			echo -n "^fg($COLOR_ICON)^i($ICONPATH/music.xbm)^fg() [paused] $MPDSONG $(echo $MPDTIME | gdbar -fg $BAR_FG -bg $BAR_BG -h $BAR_H -w $BAR_W -s o -sw 2 -ss 1 -nonl)"
		else
			echo -n "^fg($COLOR_ICON)^i($ICONPATH/music.xbm)^fg() [stopped] $(echo $MPDTIME | gdbar -fg $BAR_FG -bg $BAR_BG -h $BAR_H -w $BAR_W -s o -sw 2 -ss 1 -nonl)"
		fi
	fi

	return
}

Kernel ()
{
	KERNEL=$(uname -a | awk '{print $3}')
	echo -n "Kernel: $KERNEL"
	return
}

Date ()
{
	TIME=$(date +%l:%M%P)
		echo -n "^fg($COLOR_ICON)^i($ICONPATH/clock1.xbm)^fg(#a0a0a0) ${TIME}"
	return
}

Between ()
{
    echo -n " ^fg(#A0A0A0)^r(2x2)^fg() "
	return
}

OSLogo ()
{
	echo -n " ^fg($COLOR_ICON)^i($ICONPATH/arch1.xbm)^fg() "
	return
}

VPN()
{
	if [ -z `test -f /proc/sys/net/ipv4/conf/tun0/forwarding` ]; then
		 echo -n "VPN: On"
	else 
		echo -n "VPN: Off"
	fi
	return
}

# --------- End Of Functions

# -----
# Print 
# -----
Print () {
	MPD
	Between
	#Temp
	#Between
	Mem
	Between
	Bat
	Between
	Vol
	Between
	Date
    echo
    return
}

echo "$(Print)" 
done | $DZEN &
