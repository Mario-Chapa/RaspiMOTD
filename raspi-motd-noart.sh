color1="2"
color2="1"
upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
secs=$((${upSeconds}%60))
mins=$((${upSeconds}/60%60))
hours=$((${upSeconds}/3600%24))
days=$((${upSeconds}/86400))
UPTIME=`printf "%d days, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs"`
 
# get the load averages
read one five fifteen rest < /proc/loadavg
 
echo "$(tput setaf $color1)
 `date +"%A, %e %B %Y, %r"`
 `uname -srmo`$(tput setaf $color2)

 Uptime.............: ${UPTIME}
 Memory.............: `cat /proc/meminfo | grep MemFree | awk {'print $2'}`kB (Free) / `cat /proc/meminfo | grep MemTotal | awk {'print $2'}`kB (Total)
 Load Averages......: ${one}, ${five}, ${fifteen} (1, 5, 15 min)
 Running Processes..: `ps ax | wc -l | tr -d " "`
 IP Addresses.......: LAN: `ip a | grep glo | awk '{print $2}' | head -1 | cut -f1 -d/` | Public: `wget -q -O - http://icanhazip.com/ | tail`
 Weather............: `curl -s "http://rss.accuweather.com/rss/liveweather_rss.asp?metric=1&locCode=ASI|JP|JA041|TOKYO" | sed -n '/Currently:/ s/.*: \(.*\): \([0-9]*\)\([CF]\).*/\2°\3, \1/p'` 

$(tput sgr0)"
