speeddl=true

if [ $# -eq 0 ]
then
	echo "Usage: $0 <url>"
	exit 1
fi

for url in $@
do
	postdata="$(wget "$url" -O- -U "Mozilla/5.0 (X11; Linux x86_64; rv:25.0) Gecko/20100101 Firefox/25.0" -q | grep '<input type="hidden" name="' | awk -v ORS='&' -F'"' '{print $4"="$6}')imhuman=Watch%20video%20now"
	for i in $(seq 15)
	do
		echo -ne "\r$(tput el)$((16-$i))"
		sleep 1
	done
	echo -ne "\r$(tput el)"
	pagedata=$(wget "$url" -O- -U "Mozilla/5.0 (X11; Linux x86_64; rv:25.0) Gecko/20100101 Firefox/25.0" -q --post-data="$postdata")
	fileurl=$(echo "$pagedata" | grep 'file: "' | awk -F'"' '{print $2}')
	filename=$(echo "$pagedata" | grep '<h1 style="overflow: hidden; width: 650px; height: 24px;line-height: 24px; font-size: 18px;">' | awk -F'>' '{print $2}' | awk -F'</h1' '{print $1}' | sed 's/\\//' | sed 's/\///')
	fileext=${fileurl##*.}
	if [ "x$speeddl" == "xtrue" ]
	then
		echo "wget \"$fileurl\" -O \"$filename.$fileext\" -U \"Mozilla/5.0 (X11; Linux x86_64; rv:25.0) Gecko/20100101 Firefox/25.0\" -c -T 1 --tries=0 --waitretry=0"
		wget "$fileurl" -O "$filename.$fileext" -U "Mozilla/5.0 (X11; Linux x86_64; rv:25.0) Gecko/20100101 Firefox/25.0" -c -T 1 --tries=0 --waitretry=0
	else
		echo wget "$fileurl" -O "$filename.$fileext" -U "Mozilla/5.0 (X11; Linux x86_64; rv:25.0) Gecko/20100101 Firefox/25.0"
		wget "$fileurl" -O "$filename.$fileext" -U "Mozilla/5.0 (X11; Linux x86_64; rv:25.0) Gecko/20100101 Firefox/25.0"
	fi
done
