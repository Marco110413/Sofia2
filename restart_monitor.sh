#!/data/data/com.termux/files/usr/bin/bash
while true; do
    if ! pgrep -f "monitor.sh" > /dev/null; then
        nohup bash ~/monitor.sh & disown
    fi
    sleep 10
done
