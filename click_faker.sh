#!/bin/bash 

echo > ./log/pattern.log

#Useragents
useragents=("Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30)"
"Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; .NET CLR 1.1.4322)"
"Opera/9.20 (Windows NT 6.0; U; en)"
"Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.1) Gecko/20061205 Iceweasel/2.0.0.1 (Debian-2.0.0.1+dfsg-2)"
"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; Trident/4.0; FDM; .NET CLR 2.0.50727; InfoPath.2; .NET CLR 1.1.4322)"
"Opera/10.00 (X11; Linux i686; U; en) Presto/2.2.0"
"Mozilla/5.0 (Windows; U; Windows NT 6.0; he-IL) AppleWebKit/528.16 (KHTML, like Gecko) Version/4.0 Safari/528.16"
"Mozilla/5.0 (compatible; Yahoo! Slurp/3.0; http://help.yahoo.com/help/us/ysearch/slurp)"
"Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Firefox/3.6.13"
"Mozilla/4.0 (compatible; MSIE 9.0; Windows NT 5.1; Trident/5.0)"
"Mozilla/5.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; .NET CLR 1.1.4322; .NET CLR 2.0.50727)"
"Mozilla/4.0 (compatible; MSIE 7.0b; Windows NT 6.0)"
"Mozilla/4.0 (compatible; MSIE 6.0b; Windows 98)"
"Mozilla/5.0 (Windows; U; Windows NT 6.1; ru; rv:1.9.2.3) Gecko/20100401 Firefox/4.0 (.NET CLR 3.5.30729)"
"Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8) Gecko/20100804 Gentoo Firefox/3.6.8"
"Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.7) Gecko/20100809 Fedora/3.6.7-1.fc14 Firefox/3.6.7"
"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"
"Mozilla/5.0 (compatible; Yahoo! Slurp; http://help.yahoo.com/help/us/ysearch/slurp)")

echo -e "
  ____ _ _      _      _____     _             
 / ___| (_) ___| | __ |  ___|_ _| | _____ _ __ 
| |   | | |/ __| |/ / | |_ / _\` | |/ / _ \ '__|
| |___| | | (__|   <  |  _| (_| |   <  __/ |   
 \____|_|_|\___|_|\_\ |_|  \__,_|_|\_\___|_|   

Written by Tim Schughart | Copyright Prosec networks e.K.
"
echo -n "Please enter target url:"
read target
echo -n "Please insert number of requests:"
read requests

echo -e "Generating clicks - this can take a while"
echo -e "Check logfiles for more details"

start=1
for i in $(eval echo "{$start..$requests}") 
	do 
		tmp=$(( $RANDOM % 16 ))
		tmp=tmp+1
		curl -A $useragent[tmp] --socks5 127.0.0.1:9050 --url $target > /dev/null 2>>log/pattern.log 
		(echo "authenticate '""'; echo signal newnym; echo quit") | nc localhost 9051  &>> log/pattern.log && sleep 1
		printf "%s>%10s\r" 
		echo -en "Generated request $i" '\r'
done

