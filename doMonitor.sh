export PATH='/usr/local/sbin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin:/bin'
while IFS=, read host url keyword;do
    keywordFound=false
    if curl -s "$url" | grep "$keyword"
	then
		keywordFound=true
     fi
	response=$(curl --write-out %{http_code} --silent --output /dev/null $url)
	loadingTime=0
	if [[ "$response" == 200 || "$response" == 301 ]]; then
		loadingTime=$({ time wget -T 3 -q --delete-after $url > /dev/null; } 2>&1 | grep real | sed -E 's/[^0-9\.]+//g' | tr -d '\n' | (cat && echo " * 1000") | bc)
	fi
	export PGPASSWORD='monitor';
	psql -U monitor -d monitoring -c "INSERT INTO monitoring_entry (timestamp, host, url, response, loading_time, keyword_found) VALUES (NOW(), '$host','$url','$response','$loadingTime','$keywordFound');"

done < /Users/santtuakerman/monitoring/monitoring.conf
