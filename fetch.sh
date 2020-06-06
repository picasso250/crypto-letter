#!/bin/bash

# configuration
NAME=xiaochi
PASS=xiaochi
API="129.226.187.205:1234"

set -e

# read from net
curl -s "$API/$NAME" | while read line
do
	dt=$( echo "$line" | cut -f 1 )
	# name of other side
	other=$( echo "$line" | cut -f 2 )

	# digest
	dgst=$( echo "$line" | cut -f 4 )

	# signature
	sign=$( echo "$line" | cut -f 5 )

	echo "FROM: $other"
	echo "DATE: $dt"

	echo "$dgst"
	d2=$( echo $sign | base64 -d | openssl rsautl -verify -pubin -inkey ${other}_rsapublickey.pem )
	if [[ "$dgst" != "$d2" ]]; then
		echo "!!! Invalid signature !!!"
		echo "$d2"
	fi

	echo -n >.tmp
	echo "$line" | cut -f"6-" | tr "\t" "\n" | while read line
	do
		echo $line | base64 -d |  openssl rsautl -passin pass:"$PASS" -decrypt -inkey rsaprivatekey.pem >> .tmp
		echo >> .tmp
	done

	d3=$( openssl dgst -sha1 .tmp | cut -d' ' -f2 )
	if [[ "$dgst" != "$d3" ]]; then
		echo "!!!! Invalid signature !!!!"
		echo "$d3"
	fi

	cat .tmp
	echo
done

