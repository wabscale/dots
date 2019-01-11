#!/bin/sh

while true
do
	# using UUID so macOS reconizes it as a new file when you set it as a wallpaper
	s=$(uuidgen | tr -d '\n')

        ps -e -c -o pid=,ppid=,pcpu=,rss=,comm= | pscircle --stdin=true --show-root=1 --memlist-show=false --cpulist-show=false \
	                                                   --tree-sector-angle=3.1415 \
	                                                   --tree-rotate=true \
	                                                   --tree-rotation-angle=1.5708 \
	                                                   --tree-center=-1580:0 \
                                                           --background-color=1e2226 \
	                                                   --link-color-min=375143a0 \
	                                                   --link-color-max=375143 \
	                                                   --dot-color-min=7c762f \
	                                                   --dot-color-max=b56e46 \
	                                                   --tree-font-size=18 \
	                                                   --tree-font-color=94bfd1 \
	                                                   --tree-font-face="Noto Sans" \
	                                                   --toplists-row-height=35 \
	                                                   --toplists-font-size=24 \
	                                                   --toplists-font-color=C8D2D7 \
	                                                   --toplists-pid-font-color=7B9098 \
	                                                   --toplists-font-face="Liberation Sans" \
	                                                   --toplists-bar-height=7 \
	                                                   --toplists-bar-background=444444 \
	                                                   --toplists-bar-color=7d54dd \
                                                           --tree-radius-increment=250 \
                                                           --output="/tmp/${s}"

	osascript -e 'tell application "System Events" to set picture of every desktop to ("/tmp/'"$s"'" as POSIX file as alias)'

	rm /tmp/$s

	sleep 1
done
