#### Calomel.org  ad_servers_newlist.sh 
#
## get new ad server list
curl -sS -L --compressed "http://pgl.yoyo.org/adservers/serverlist.php?hostformat=nohtml&showintro=0&mimetype=plaintext" > /usr/local/etc/squid/ad_block.txt 

## refresh squid
/usr/local/sbin/squid -k reconfigure
